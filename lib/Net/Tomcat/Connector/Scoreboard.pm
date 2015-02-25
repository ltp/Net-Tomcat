package Net::Tomcat::Connector::Scoreboard;

use strict;
use warnings;

use  Net::Tomcat::Connector::Scoreboard::Entry;

our $VERSION    = '0.01';
our @ATTR       = qw();
our %STATES     = (     
                        R => 'ready', 
                        P => 'parse', 
                        S => 'service', 
                        F => 'finish',
                        K  => 'keepalive'
                );

foreach my $attr ( @ATTR ) {{
        no strict 'refs';
        *{ __PACKAGE__ . '::' . $attr } = sub { my $self = shift; return $self->{$attr} }
}}

foreach my $state ( keys %STATES ) {{
        no strict 'refs';
        *{ __PACKAGE__ . '::threads_' . $STATES{ $state } } = sub { 
                my $self = shift;
                return grep { $_->{stage} eq $state } @{ $self->{__threads} }
        }
}}

sub new {
        my ( $class, @args ) = @_;
        my $self = bless {}, $class;
        $self->{__timestamp} = time;
        my @h = @{ shift @args };

        for ( @args ) {
                my %a;
                @a{ @h } = @{ $_ };
                push @{ $self->{__threads} }, Net::Tomcat::Connector::Scoreboard::Entry->new( %a );
        }

        return $self;
}

sub threads             { return @{ $_[0]->{__threads } }       }

sub thread_count        { return scalar @{ $_[0]->{__threads} } }

sub threads_for_vhost {
        my ( $self, $vhost ) = @_;
        return grep { $_->{vhost} eq $vhost } @{ $self->{__threads} };
        #my @threads = $self->threads;
}

sub __timestamp         { return $_[0]->{__timestamp}           }

1;
__END__

=head1 NAME

Net::Tomcat::Connector::Scoreboard - Utility class for representing abstract 
Tomcat Connector scoreboard objects.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

A Net::Tomcat::Connector::Scoreboard object is an abstract collection of
L<Net::Tomcat::Connector::Scoreboard::Entry> objects.  This class exists
to provide higher level functions and syntactic sugar for accessing the
aforementioned objects.

        use Net::Tomcat;

        # Create a new Net::Tomcat object
        my $tc = Net::Tomcat->new(
                                username => 'admin',
                                password => 'password',
                                hostname => 'web-server-01.company.com'
                              ) 
                or die "Unable to create new Net::Tomcat object: $!\n";

        # Retrieve a Net::Tomcat::Connector::Scoreboard object by explicit
        # connector name
        my $stats = $tc->connector('http-8080')->scoreboard;



=head1 METHODS

=head3 new

Constructor - creates a new Net::Tomcat::Connector::Statistics object.  Note 
that you should not normally need to call the constructor method directly as a 
Net::Tomcat::Connector::Statistics object will be created for you on invoking 
methods in parent classes.


=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-tomcat-connector-statistics 
at rt.cpan.org>, or through the web interface at 
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Tomcat-Connector-Statistics>.
I will be notified, and then you'll automatically be notified of progress on 
your bug as I make changes.
