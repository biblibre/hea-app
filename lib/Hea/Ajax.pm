package Hea::Ajax;
use Dancer::Plugin::Database;

sub bibVolumetryRange {
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
	    $range->{'150001-'}++;
	}
    }

    my $nodes;
    foreach my $key (keys %$range) {
	push @{ $nodes }, { 'range' => $key, 'count' => $range->{$key} };
    }

    return $nodes;

}

1;
