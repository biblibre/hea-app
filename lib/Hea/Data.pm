package Hea::Data;
use Dancer ':syntax';

use Dancer::Plugin::Database;


our $VERSION = '0.1';

sub getLibraryCount{
    database->quick_count('library', {});
}

sub getMarcFlavourRepartition{
    my $nb_unimarc = database->quick_count('library', { });
}

true;
