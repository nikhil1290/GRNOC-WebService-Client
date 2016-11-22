#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use FindBin;
use lib "$FindBin::Bin/..";
use CGI;
use Helper;

my $cgi = new CGI;

my $counter_file = "$FindBin::Bin/../count.json";

if($cgi->param('status') && $cgi->param('method')) {
    my $status = $cgi->param('status');
    Helper::increment_counter( $counter_file );
    print $cgi->header(-type => "text/plain", -status => "$status");

}
elsif( $cgi->param('method')){
    print $cgi->header(-type => "text/plain");
    print "OK";
}
else{
    print $cgi->header(-type => "text/plain", -status => "404 Not Found");
    print "404 Not Found";
}

1;
