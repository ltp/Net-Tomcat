package Net::Tomcat::JVM;

use strict;
use warnings;

our $VERSION    = '0.01';
our @ATTR       = qw(free_memory total_memory max_memory);

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
