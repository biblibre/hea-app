package Hea::Data;

use Modern::Perl;
use Dancer ':syntax';
use Dancer::Plugin::Database;

our $VERSION = '0.1';

our $appdir = $ENV{DANCER_APPDIR};

# retrieve the number of libraries declared
sub getLibraryCount {
    database->quick_count( 'library', {} );
}

# retrieves the sum of biblios in all libraries
sub getKohaTableStats {
    my $table = shift;
    my $sth   = database->prepare(q|
        SELECT sum(value),AVG(value),MIN(value),MAX(value)
        FROM volumetry
        WHERE name=?
    |);
    $sth->execute($table);
    return $sth->fetchrow;
}

sub getMarcFlavourRepartition {
    return {
        unimarc => database->quick_count(
            'systempreference', { name => 'marcflavour', value => 'UNIMARC' }
        ),
        normarc => database->quick_count(
            'systempreference', { name => 'marcflavour', value => 'NORMARC' }
        ),
        marc21 => database->quick_count(
            'systempreference', { name => 'marcflavour', value => 'MARC21' }
        ),
    };
}

sub writeMarcFlavourCsv {
    my $marcflavourrepartition = Hea::Data::getMarcFlavourRepartition;
    open( my $fh, '>', $appdir . 'public/data/donut_flavours.csv' )
      or die "Cannot open donut csv file ($!)";
    print $fh "flavour,number\n";
    foreach my $key ( keys %$marcflavourrepartition ) {
        print $fh "$key,$marcflavourrepartition->{$key}\n";
    }
    close $fh;
}

sub getBibVolumetryRange {
    my $sth = database->prepare(q|
        SELECT *
        FROM volumetry
        WHERE name = ?
    |);
    $sth->execute('biblio');
    my $data = $sth->fetchall_arrayref( {} );

    my $range = {
        '0-15000'      => 0,
        '15001-50000'  => 0,
        '50001-150000' => 0,
        '150001-'      => 0,
    };
    foreach my $entry (@$data) {
        my $num = $entry->{value};
        if ( $num <= 15000 ) {
            $range->{'0-15000'}++;
        }
        if ( $num > 15000 && $num <= 50000 ) {
            $range->{'15001-50000'}++;
        }
        if ( $num > 50000 && $num <= 150000 ) {
            $range->{'50001-150000'}++;
        }
        if ( $num > 150000 ) {
            $range->{'150001-...'}++;
        }
    }

    my $nodes;
    foreach my $key ( keys %$range ) {
        push @{$nodes}, { 'range' => $key, 'count' => $range->{$key} };
    }

    return $nodes;

}

sub writeBibRangeCsv {
    my $bibVolumetryRange = Hea::Data::getBibVolumetryRange;
    open my $fh, '>', $appdir . 'public/data/donut_bibrange.csv'
      or die "Cannot open donut csv file ($!)";
    print $fh "bibrange,number\n";
    foreach my $d ( @{$bibVolumetryRange} ){
        print $fh "$d->{range},$_->{count}\n";
    } close $fh;
}

1;
