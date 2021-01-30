package Hea::Data;

use Modern::Perl;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Data::Dumper;

our $VERSION = '0.2';

# retrieve the number of libraries declared
sub getLibraryCount {
    database->quick_count( 'library', {} );
}

# retrieves the sum of biblios in all libraries
sub volumetry_stats {
    my ( $type ) = @_;
    return unless $type;
    my $sth   = database->prepare(q|
        SELECT sum(value) as sum, AVG(value) as avg, MAX(value) as max, stddev_pop(value) as std
        FROM volumetry
        WHERE name=?
    |);
    $sth->execute($type);
    my $tmp = $sth->fetchrow_hashref;
    $tmp->{med}=volumetry_median($type);
    return $tmp;
}

sub volumetry_median {
    my ( $type ) = @_;
    return unless $type;
    my $sth   = database->prepare(q|
        SELECT AVG(value) as med
        FROM
        (
            SELECT @counter:=@counter+1 as row_id, v1.value
            FROM volumetry v1, (select @counter:=0) v2
            WHERE v1.name=?
            ORDER BY v1.value
        ) o1
        JOIN
        (
            SELECT count(*) as total_rows
            FROM volumetry
            WHERE name=?
        ) o2
        WHERE o1.row_id in (FLOOR((o2.total_rows + 1)/2), FLOOR((o2.total_rows + 2)/2))
    |);
    $sth->execute($type, $type);
    my $tmp = $sth->fetchrow_hashref;
    return $tmp->{med};
}

sub syspref_repartition {
    my $sth = database->prepare(q|
        SELECT name, value, count(*) as count
        FROM systempreference
        GROUP BY name, value
    |);
    $sth->execute;
    my $data = $sth->fetchall_arrayref( {} );
    my $pref_repartition;
    for my $d ( @$data ) {
        push @{$pref_repartition->{$d->{name}}}, { name => $d->{value}, value => $d->{count} };
    }
    return $pref_repartition;
}

sub volumetry_range {
    my ( $type ) = @_;
    return unless $type;
    my $sth = database->prepare(q|
        SELECT *
        FROM volumetry
        WHERE name = ?
    |);
    $sth->execute($type);
    my $data = $sth->fetchall_arrayref( {} );

    my $range;
    if ( $type eq 'borrowers' || $type eq 'subscription' || $type eq 'aqorders' || $type eq 'old_reserves' ) {
         $range = { 1 => 1500, 2 => 5000, 3 => 15000 };
    } else {
        $range = { 1 => 15000, 2 => 50000, 3 => 150000 };
    }

    my $vol;
    foreach my $entry (@$data) {
        my $num = $entry->{value} || 0;
        if ( $num < $range->{1} ) {
            $vol->{1}++;
        } elsif ( $num > $range->{1} and $num <= $range->{2} ) {
            $vol->{2}++;
        } elsif ( $num > $range->{2} and $num <= $range->{3} ) {
            $vol->{3}++;
        } elsif ( $num > $range->{3} ) {
            $vol->{4}++;
        }
    }

    return [
        {name => "0-$range->{1}", value => $vol->{1} || 0},
        {name => "$range->{1}-$range->{2}", value => $vol->{2} || 0},
        {name => "$range->{2}-$range->{3}", value => $vol->{3} || 0},
        {name => "$range->{3}+", value => $vol->{4} || 0},
    ];
}

sub library_stats {
    my ( $type ) = @_;
    return unless $type;

    my $query = "
        SELECT $type as name, COUNT(*) AS value
        FROM library
        WHERE $type <> ''
        GROUP BY $type
    ";

    my $sth = database->prepare($query);
    $sth->execute();
    my $data = $sth->fetchall_arrayref( {} );

    return $data;
}

sub libraries_name_and_url {
    my $query = q|
            SELECT name, url
            FROM library
            WHERE name <> '' OR url <> ''
            ORDER by name
    |;
    my $sth = database->prepare($query);
    $sth->execute();

    return $sth->fetchall_arrayref( {} );
}

1;
