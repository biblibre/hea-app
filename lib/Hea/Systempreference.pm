package Hea::Systempreference;

use Dancer ':syntax';
use Dancer::Plugin::Database;

our $VERSION = '0.1';

sub getNames {
    database->selectcol_arrayref(
      "SELECT DISTINCT name FROM systempreference ORDER BY name"
    );
}

sub writeCsv {
  my ($name) = @_;

  my $results = database->selectall_arrayref(
    "SELECT value, COUNT(*) FROM systempreference WHERE name = ? GROUP BY value",
    undef, $name
  );

  open (FILE, '>', 'public/data/systempreference_' . $name . '.csv');
  print FILE "value,count\n";
  foreach my $row (@$results) {
    print FILE $row->[0], ',', $row->[1], "\n";
  }
  close (FILE);
}

1;
