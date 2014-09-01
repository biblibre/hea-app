package Hea::App;
use Dancer ':syntax';
use Hea::Data;
use Hea::Systempreference;
use Hea::Ajax;
use Template;
use JSON;


get '/' => sub {
    my $library_count = Hea::Data::getLibraryCount;
    my ($biblio_sum, $biblio_avg, $biblio_min, $biblio_max ) = Hea::Data::getKohaTableStats('biblio');
    Hea::Data::writeMarcFlavourCsv;
    Hea::Data::writeBibRangeCsv;
    template 'index' => { 
      library_count  => $library_count,
      biblio_sum     => $biblio_sum,
      biblio_avg     => $biblio_avg,
      biblio_min     => $biblio_min,
      biblio_max     => $biblio_max,
      load_d3j       => 1,
      donut_flavours => 1,
      donut_bibrange => 1
    };
};

get '/ajax/libvolumetry' => sub {
    my $range = Hea::Ajax::bibVolumetryRange;
    return to_json($range);
};

get '/systempreference' => sub {
    template 'systempreference' => {
        names => Hea::Systempreference::getNames(),
    };
};

post '/systempreference' => sub {
    redirect '/systempreference/' . params->{preferencename};
};

get '/systempreference/:preferencename' => sub {
    my $name = params->{preferencename};
    Hea::Systempreference::writeCsv($name);
    template 'systempreference' => {
        names => Hea::Systempreference::getNames(),
        preferencename => $name,
    };
};

true;
