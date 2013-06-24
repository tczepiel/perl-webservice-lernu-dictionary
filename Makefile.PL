use strict;
use warnings;

use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Webservice::Lernu::Dictionary',
    VERSION_FROM      => 'lib/Webservice/Lernu/Dictionary.pm',
    PREREQ_PM         => {
        URI => 0,
        'LWP::UserAgent' => 0,
        Moo => 0,
        'List::MoreUtils' => 0,
    },
    ($] >= 5.005 ?
      (ABSTRACT       => 'Dictionary API for lernu! ( http://lernu.net )',
       AUTHOR         => 'Tomasz Czepiel <tjmc@cpan.org>') : ()),
);
