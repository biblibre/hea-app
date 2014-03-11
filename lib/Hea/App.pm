package Hea::App;
use Dancer ':syntax';
use Hea::Data;
use Hea::Ajax;
use Template;
use JSON;


get '/' => sub {
    my $library_count = Hea::Data::getLibraryCount;
    my $marcflavourrepartition = Hea::Data::getMarcFlavourRepartition;
    Hea::Data::writeMarcFlavourCsv;
    template 'index' => { 
      library_count => $library_count,
      load_d3j => 1,
      donut_flavours => 1
    };
};

get '/ajax/libvolumetry' => sub {
    my $range = Hea::Ajax::bibVolumetryRange;
    return to_json($range);
};

true;
