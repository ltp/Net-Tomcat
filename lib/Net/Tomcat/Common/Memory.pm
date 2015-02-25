package Net::Tomcat::Common::Memory;

use strict;
use warnings;

our $VERSION    = '0.01';
our @ATTR       = qw(free_memory total_memory max_memory);

for ( @ATTR ) { { 
        no strict 'refs';
        *{ __PACKAGE__ . "::$_" } = sub { my $s = shift; return $s->{$_} }      
} }

sub new {
        my ( $class, %args ) = @_;

        my $self = bless {}, $class;
        $self->{$_} = $args{$_} for @ATTR;
        $self->{__timestamp} = localtime;

        return $self
}

sub __timestamp { return $_[0]->{__timestamp} }

1;
