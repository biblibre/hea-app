package Hea::Data;

use Modern::Perl;
use Dancer ':syntax';
use Dancer::Plugin::Database;

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
        SELECT sum(value) as sum, AVG(value) as avg, MIN(value) as min, MAX(value) as max
        FROM volumetry
        WHERE name=?
    |);
    $sth->execute($type);
    return $sth->fetchrow_hashref;
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

sub range {
    my ( $type ) = @_;
    return unless $type;

    my $query;
    if ($type eq 'country'){
        $query =
            'SELECT country
             FROM library
             ORDER BY country';
    }
    elsif ($type eq 'library_type'){
        $query =
            'SELECT library_type
             FROM library';
    }
    my $sth = database->prepare($query);
    $sth->execute();
    my $data = $sth->fetchall_arrayref( {} );

    my $vol;
    foreach my $entry (@$data) {
        my $element = $entry->{$type} || 0;
        $vol->{$element}++;
    }

    my $range;
    foreach my $k (sort keys $vol){
        push @$range, {
            name => $k,
            value => $vol->{$k}
        }
    }

    return $range;
}

sub libraries_name_and_url {
    my $query = q|
            SELECT name, url
            FROM library
            WHERE name <> '' OR url <> ''
    |;
    my $sth = database->prepare($query);
    $sth->execute();

    return $sth->fetchall_arrayref( {} );
}

1;
