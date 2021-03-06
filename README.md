NAME
====
Net::Tomcat - A Perl API for monitoring Apache Tomcat.

VERSION
=======
Version 0.01

SYNOPSIS
========
Net::Tomcat is a Perl API for monitoring Apache Tomcat instances.

       use Net::Tomcat;

       # Create a new Net::Tomcat object
       my $tc = Net::Tomcat->new(
			       username => 'admin',
			       password => 'password',
			       hostname => 'web-server-01.company.com'
			     )
	       or die "Unable to create new Net::Tomcat object: $!\n";

       # Print the Tomcat server version and JVM version information
       print "Tomcat version: " . $tc->server->version . "\n"
	   . "JVM version: " . $tc->server->jvm_version . "\n";

       # Get all connectors as an array of Net::Tomcat::Connector objects
       my @connectors = $tc->connectors;

       # Print the connector names, and request and error counts
       foreach my $connector ( @connectors ) {
	       print "Name: " . $connector->name . "\n"
		   . "Request Count: ".$connector->request_count . "\n"
		   . "Error Count: ".$connector->error_count . "\n\n"
       }

       # Directly access a connector by name
       print "http-8080 error count: "
	       . $tc->connector('http-8080')->stats->error_count . "\n";

       # Retrieve a Net::Tomcat::Connector::Scoreboard object
       # representing the request scoreboard of the connector.
       my $scoreboard = $tc->connector('http-8080')->scoreboard;

       # Get all threads in a servicing state as
       # Net::Tomcat::Connector::Scoreboard::Entry objects.
       my @threads = $scoreboard->threads_service;

METHODS
=======
### new ( %ARGS )
Constructor - creates a new Net::Tomcat object.  This method takes three mandatory parameters and accepts six optional
parameters.

### username
A valid username of a user account with access to the Tomcat management pages.

### password
The password for the user account given for the username parameter above.

### hostname
The resolvable hostname or IP address of the target Tomcat server.

### port
The target port on the target Tomcat server on which to connect.

If this parameter is not specified then it defaults to port 8080.

### proto
The protocol to use when connecting to the target Tomcat server.

If this parameter is not specified then it defaults to HTTP.

### app_status_url
The relative URL of the Tomcat Web Application Manager web page.

This parameter is optional and if not provided will default to a value of '/manager/html/list'.

If this parameter is provided then it should be a relative URL in respect to the hostname parameter.

### server_status_url
The relative URL of the Tomcat Web Server Status web page.

This parameter is optional and if not provided will default to a value of '/manager/status/all'.

If this parameter is provided then it should be a relative URL in respect to the hostname parameter.

### refresh_interval
The interval in seconds after which any retrieved results should be regarded as invalid and discarded.  After this period has
elapsed, subsequent requests for cached values will be issued to the Tomcat instance and the results will be cached for the
duration of the refresh_interval period.

Note that the refresh interval applies to all objects individually - that is; a Net::Tomcat::Connector object may have a
different refresh interval than a Net::Tomcat::Connector::Scoreboard object.

This parameter is optional and defaults to 3600s.  Caution shoudl be exercised when setting this parameter to avoid potential
inconsistency in sequential calls to assumed immutable objects.

### connector ( $CONNECTOR )

       # Print connector error count.
       my $connector = $tc->connector( 'http-8080' );
       print "Connecter http-8080 error count: "
	       . $connector->stats->error_count . "\n";

       # Or
       printf( "Connector %s error count: %s\n",
	       $tc->connector('http-8080')->name,
	       $tc->connector('http-8080')->stats->error_count
       );

Returns a Net::Tomcat::Connector object where the connector name is identified by the named $CONNECTOR parameter.

### connectors
Returns an array of Net::Tomcat::Connector objects representing all connector instances on the server.

### server
Returns a Net::Tomcat::Server object for the current instance.

### jvm
Returns a Net::Tomcat::JVM object for the current instance.

AUTHOR
======
Luke Poskitt, <ltp@cpan.org>

REPOSITORY
==========
<https://github.com/ltp/Net-Tomcat>

SEE ALSO
========
Net::Tomcat::Server Net::Tomcat::Connector Net::Tomcat::Scoreboard

BUGS
====
Please report any bugs or feature requests to "bug-net-tomcat at rt.cpan.org", or through the web interface at
<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Tomcat>.  I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

SUPPORT
=======
You can find documentation for this module with the perldoc command.

      perldoc Net::Tomcat

You can also look for information at:

* RT: CPAN's request tracker (report bugs here)  <http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-Tomcat>

* AnnoCPAN: Annotated CPAN documentation  <http://annocpan.org/dist/Net-Tomcat>

* CPAN Ratings  <http://cpanratings.perl.org/d/Net-Tomcat>

* Search CPAN  <http://search.cpan.org/dist/Net-Tomcat/>

LICENSE AND COPYRIGHT
=====================
Copyright 2015 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it under the terms of the the Artistic License (2.0). You
may obtain a copy of the full license at:

<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified Versions is governed by this Artistic License. By using,
modifying or distributing the Package, you accept this license. Do not use, modify, or distribute the Package, if you do not
accept this license.

If your Modified Version has been derived from a Modified Version made by someone other than you, you are nevertheless required
to ensure that your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge patent license to make, have made, use, offer to sell, sell,
import and otherwise transfer the Package with respect to any patent claims licensable by the Copyright Holder that are
necessarily infringed by the Package. If you institute patent litigation (including a cross-claim or counterclaim) against any
party alleging that the Package constitutes direct or contributory patent infringement, then this Artistic License to you shall
terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES.  THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT ARE
DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.

