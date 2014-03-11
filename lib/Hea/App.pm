package Hea::App;
use Dancer ':syntax';
use Hea::Data;
use Template;


get '/' => sub {
    my $count = Hea::Data::getLibraryCount;
    debug "count: $count";
    template 'index' => { library_count => $count };
};

true;
