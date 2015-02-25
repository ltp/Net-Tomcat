#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Net::Tomcat' ) || print "Bail out!\n";
}

diag( "Testing Net::Tomcat $Net::Tomcat::VERSION, Perl $], $^X" );
