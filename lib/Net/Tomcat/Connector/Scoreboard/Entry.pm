package Net::Tomcat::Connector::Scoreboard::Entry;

use strict;
use warnings;

our $VERSION    = '0.01';
our @ATTR       = qw(stage time client vhost request);

foreach my $attr ( @ATTR ) {{
        no strict 'refs';
        *{ __PACKAGE__ . "::$attr" } = sub {
                my ( $self, $val ) = @_;
                $self->{$attr} = $val if $val;

                return $self->{$attr} }
}}

sub new {
        my ( $class, %args )    = @_;
        
        my $self                = bless {}, $class;
        $self->{$_}             = $args{$_} for @ATTR;

        return $self
}

sub bytes_sent          { return $_[0]->{b_sent}        }

sub bytes_received      { return $_[0]->{b_recv}        }

1;

__END__

=head1 NAME

Net::Tomcat::Connector::Scoreboard::Entry - Utility class for representing 
Tomcat Connector scoreboard entries.

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
