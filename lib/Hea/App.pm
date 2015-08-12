package Hea::App;

use Modern::Perl;
use Dancer ':syntax';
use Hea::Data;
use Template;
use JSON qw( to_json );
use I18N::LangTags::Detect;

get '/' => sub {
    my @languages     = I18N::LangTags::Detect::detect();
    my $library_count = Hea::Data::getLibraryCount;

    my $biblio_stats       = Hea::Data::volumetry_stats('biblio');
    my $authority_stats    = Hea::Data::volumetry_stats('auth_header');
    my $item_stats         = Hea::Data::volumetry_stats('items');
    my $patron_stats       = Hea::Data::volumetry_stats('borrowers');
    my $issue_stats        = Hea::Data::volumetry_stats('old_issues');
    my $reserve_stats      = Hea::Data::volumetry_stats('old_reserves');
    my $order_stats        = Hea::Data::volumetry_stats('aqorders');
    my $subscription_stats = Hea::Data::volumetry_stats('subscription');

    my $biblio_volumetry       = to_json Hea::Data::volumetry_range('biblio');
    my $authority_volumetry    = to_json Hea::Data::volumetry_range('auth_header');
    my $item_volumetry         = to_json Hea::Data::volumetry_range('items');
    my $patron_volumetry       = to_json Hea::Data::volumetry_range('borrowers');
    my $issue_volumetry        = to_json Hea::Data::volumetry_range('old_issues');
    my $reserve_volumetry      = to_json Hea::Data::volumetry_range('old_reserves');
    my $order_volumetry        = to_json Hea::Data::volumetry_range('aqorders');
    my $subscription_volumetry = to_json Hea::Data::volumetry_range('subscription');
    my $country_volumetry      = to_json Hea::Data::range('country');
    my $type_volumetry         = to_json Hea::Data::range('library_type');

    template 'index' => {
        library_count          => $library_count,
        biblio_stats           => $biblio_stats,
        authority_stats        => $authority_stats,
        item_stats             => $item_stats,
        patron_stats           => $patron_stats,
        issue_stats            => $issue_stats,
        reserve_stats          => $reserve_stats,
        order_stats            => $order_stats,
        subscription_stats     => $subscription_stats,
        biblio_volumetry       => $biblio_volumetry,
        authority_volumetry    => $authority_volumetry,
        item_volumetry         => $item_volumetry,
        patron_volumetry       => $patron_volumetry,
        issue_volumetry        => $issue_volumetry,
        reserve_volumetry      => $reserve_volumetry,
        order_volumetry        => $order_volumetry,
        subscription_volumetry => $subscription_volumetry,
        country_volumetry      => $country_volumetry,
        type_volumetry         => $type_volumetry,
        v                      => 'home',
        languages              => \@languages,
    };
};

get '/systempreferences' => sub {
    my $systempreferences = Hea::Data::syspref_repartition;
    my @prefs;
    while ( my ( $pref_name, $values ) = each $systempreferences ) {
        push @prefs, { syspref_name => $pref_name, values => to_json $values };
    }

    template 'systempreferences' => {
        systempreferences => \@prefs,
        v => 'systempreferences',
    };
};

true;
