package Hea::Systempreference;

use Modern::Perl;

use Dancer ':syntax';
use Dancer::Plugin::Database;

our $VERSION = '0.1';

our $appdir = $ENV{DANCER_APPDIR};

sub getNames {
    database->selectcol_arrayref(
        'SELECT DISTINCT name FROM systempreference ORDER BY name' );
}

sub writeCsv {
    my ($name) = @_;

    my $results = database->selectall_arrayref(q|
        SELECT value, COUNT(*)
        FROM systempreference
        WHERE name = ?
        GROUP BY value
    |, undef, $name );

    open( my $fh, '>', $appdir . "public/data/systempreference_$name.csv" )
      or die "Cannot open systempreference csv file ($!)";
    print $fh "value,count\n";
    foreach my $row (@$results) {
        print $fh $row->[0], ',', $row->[1], "\n";
    }
    close $fh;
}

1;
