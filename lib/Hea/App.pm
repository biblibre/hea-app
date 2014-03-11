package Hea::App;
use Dancer ':syntax';
use Hea::Data;
use Template;


get '/' => sub {
    my $count = Hea::Data::getLibraryCount;
    template 'index' => { library_count => $count };
};

true;
