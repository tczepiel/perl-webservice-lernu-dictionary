use strict;
use warnings;

use Test::More qw(no_plan);
use Webservice::Lernu::Dictionary;
use Data::Dumper;

my $api = Webservice::Lernu::Dictionary->new(
);

my $r = $api->translate(
    delingvo => 'eo',
    allingvo => 'en',
    modelo   => 'bovino',
);

diag(Dumper($r));

ok(ref($r));

pass 'kewl';


