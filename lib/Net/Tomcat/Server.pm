package Net::Tomcat::Server;

use strict;
use warnings;

our $VERSION    = '0.01';
our @ATTR       = qw(jvm_vendor jvm_version os_architecture os_name os_version tomcat_version);

foreach my $attr ( @ATTR ) {{
        no strict 'refs';
        *{ __PACKAGE__ . '::' . $attr } = sub { my $self = shift; return $self->{$attr} }
}}

sub new {
        my ( $class, %args ) = @_;
        my $self = bless {}, $class;
        $self->{$_} = $args{$_} for @ATTR;
        $self->{__timestamp} = time;

        return $self;
}

sub __timestamp { return $_[0]->{__timestamp} }

1;
