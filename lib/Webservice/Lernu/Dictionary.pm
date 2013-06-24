package Webservice::Lernu::Dictionary;

use URI;
use LWP::UserAgent;
use Moo;
use List::MoreUtils qw(natatime);
use Encode;

has config => (
    is => 'ro',
);

has ua => (
    is => 'ro',
    isa => { 1 }, #todo
);

sub _build_config {

    my $self = shift;
    $self->config({
        api => 'http://en.lernu.net/cgi-bin/serchi.pl',
    });
}

sub BUILD {
    my $self = shift;
    $self->_build_config();

    return $self;
}

sub translate {
    my $self = shift;
    my %args = @_;
    my $url  = URL->new($self->config->{api});
    $uri->query_params(%args);
    my $ret = $self->ua->get($uri->as_string);

    return unless $r;
    my $href = $self->_to_hash($ret);
    

}

sub _to_hash {
    my $self = shift;
    my $s    = shift;
    my @definitions = split "\n", $s;
    
    my $n        = natatime 3, @definitions;
    my $word_def = qx/^(\d+)\s+(\w+)\s+(\w+)(\d+)\s+(\w)$/;

    my @return;
    while ( my ($definition,$translation,$separator) = $n->() ) {
        die "don't know what to do with the data" if $separator;
     
        push @return, {
            definition => 
        };
    }

}

1;

__END__

curl 'http://en.lernu.net/cgi-bin/serchi.pl?modelo=sian&delingvo=eo&allingvo=en' > sian.txt


14643   gibono  gibon/o     0   n
239896  en  Angla   gibbon  2005-11-17 11:51:46

14645   giĉeto  giĉet/o     0   n
908993  en  Angla   ticket-window, booking office   2012-08-10 19:06:39 Chainy

14646   Gideono Gideon/o        0   n
239898  en  Angla   Gideon  2005-11-17 11:51:46

14648   giganta gigant/a    gigant·o    0   n
239899  en  Angla   gigantic, huge  2005-11-17 11:51:46

14650   giganto gigant/o        0   n
239900  en  Angla   giant   2005-11-17 11:51:46

14654   gildo   gild/o      0   n
239901  en  Angla   guild   2005-11-17 11:51:46

