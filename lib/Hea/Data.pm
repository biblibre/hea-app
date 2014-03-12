package Hea::Data;
use Dancer ':syntax';

use Dancer::Plugin::Database;

our $VERSION = '0.1';

sub getLibraryCount{
    database->quick_count('library', {});
}

sub getMarcFlavourRepartition{
    return {
      unimarc => database->quick_count('systempreference', { name => 'marcflavour',value =>'UNIMARC' }),
      normarc => database->quick_count('systempreference', { name => 'marcflavour',value =>'NORMARC'  }),
      marc21  => database->quick_count('systempreference', { name => 'marcflavour',value =>'MARC21'  }),
    };
}

sub writeMarcFlavourCsv {
    my $marcflavourrepartition = Hea::Data::getMarcFlavourRepartition;
    open(FILE, '>', 'public/data/donut_flavours.csv');
    print FILE "flavour,number\n";
    foreach my $key (keys %$marcflavourrepartition) {
        print FILE "$key,$marcflavourrepartition->{$key}\n";
    }
    close(FILE);
}

sub getBibVolumetryRange {
    my $sth = database->prepare(
        'select * from volumetry where name = ?',
    );
    $sth->execute('biblio');
    my $data = $sth->fetchall_arrayref({});

    my $range = {
	'0-15000' => 0,
	'15001-50000' => 0,
	'50001-150000' => 0,
	'150001-' => 0,
    };
    foreach my $entry (@$data) {
	my $num = $entry->{value};
	if ($num <= 15000) {
	    $range->{'0-15000'}++;
	}
	if ($num > 15000 && $num <= 50000) {
	    $range->{'15001-50000'}++;
	}
	if ($num > 50000 && $num <= 150000) {
	    $range->{'50001-150000'}++;
	}
	if ($num > 150000) {
	    $range->{'150001-...'}++;
	}
    }

    my $nodes;
    foreach my $key (keys %$range) {
	push @{ $nodes }, { 'range' => $key, 'count' => $range->{$key} };
    }

    return $nodes;

}

sub writeBibRangeCsv {
    my $bibVolumetryRange = Hea::Data::getBibVolumetryRange;
    open(FILE, '>', 'public/data/donut_bibrange.csv');
    print FILE "bibrange,number\n";
    foreach (@{ $bibVolumetryRange }) {
        print FILE "$_->{range},$_->{count}\n";
    }
    close(FILE);
}
1;
