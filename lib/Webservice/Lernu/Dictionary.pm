package Webservice::Lernu::Dictionary;
use utf8;

use strict;
use warnings;
use URI;
use LWP::UserAgent;
use Moo;
use List::MoreUtils qw(natatime);
use Encode;
use Data::Dumper;

has config => (
    is => 'rw',
);

has ua => (
    is => 'rw',
    isa => sub { 1 }, #todo
);

has ua_args => (
    is => 'rw',
);

sub _build_ua {
    my $self = shift;
    $self->ua(LWP::UserAgent->new());
}

sub _build_config {

    my $self = shift;
    $self->config({
        api => 'http://en.lernu.net/cgi-bin/serchi.pl',
    });
}

sub BUILD {
    my $self = shift;

    $self->_build_config();
    $self->_build_ua();

    return $self;
}

sub translate {
    my $self = shift;
    

    my %args = @_;
    my $url  = URI->new($self->config->{api});
    $url->query_form(%args);
    #warn $url->as_string;
    my $ret = $self->ua->get($url->as_string);

    return unless $ret->is_success;
    return $self->_parse_response(\$ret->decoded_content);
}

sub _parse_response {
    my $self = shift;
    my $s    = shift;

    my @definitions = split "\n", $$s;
    shift @definitions; pop @definitions;
    #warn "definitions ". Dumper \@definitions;
    
    my $n        = natatime 3, @definitions;
    my $word_def  = qr/(?<word_id>\d*)\s+(?<word_n>\w*).(?<word_stem_suffix>\w*)\s+(?<word_declension>\d*)\s+(?<word_type>\w*)/;
    my $trans_def = qr/(?<trans_id>\d*)\s+(?<lang_code>\w*)\s+(?<eo_lang_name>\w*)\s+(?<translation>\w*)/;

    my @return;
    while ( my ($definition,$translation,$separator) = $n->() ) {
        die "don't know what to do with the data" if $separator;

        $definition  =~ /$word_def/;
        my %definition  = map { $_ => $+{$_} } (qw( word_id word_n word_stem_suffix word_declension word_type ));

        $translation =~ /$trans_def/;
        my %translation = map { $_ => $+{$_} } (qw( trans_id lang_code eo_lang_name translation ));
     
        push @return, {
            definition  => \%definition,
            translation => \%translation,
        };
#        warn $definition;
#        warn Dumper \%definition;
#        warn $translation;
#        warn Dumper \%translation;
    }
    return \@return;
}

1;

__END__

http://nl.lernu.net/cgi-bin/serchi.pl?modelo=filozofio&delingvo=eo&allingvo=en


14643   gibono  gibon/o     0   n
239896  en  Angla   gibbon  2005-11-17 11:51:46

14645   giĉeto  giĉet/o     0   n
908993  en  Angla   ticket-window, booking office   2012-08-10 19:06:39 Chainy

14650   giganto gigant/o        0   n
239900  en  Angla   giant   2005-11-17 11:51:46

14654   gildo   gild/o      0   n
239901  en  Angla   guild   2005-11-17 11:51:46

