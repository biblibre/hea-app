use Test::More tests => 1;
use Hea::Data;
use strict;
use warnings;

use_ok 'Hea::Data';

my $got = Hea::Data::getLibraryCount;
my $expected = 2;
my $test_name = 'Count Libraries';
is ($got, $expected, $test_name);
