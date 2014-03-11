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
1;
