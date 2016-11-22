use Test::More tests => 5;

use strict;
use GRNOC::WebService::Client;
use Data::Dumper;
use FindBin;
use lib "$FindBin::Bin";
use Helper;

my $counter_file = "$FindBin::Bin/count.json";
my $retries;
my $retry_interval;
my $svc = GRNOC::WebService::Client->new( url => "http://localhost:8529/hello.cgi",
                                          raw_output => 1,
                                          retry_error_codes => { '408' => 1 }
                                                            );


#verify default retries is 0
$retries = $svc->get_retries();
is($retries, 0, "Default retries is zero");

#verify default retry interval is 5 secs
$retry_interval = $svc->get_retry_interval();
is($retry_interval, 5 , "Default retry interval is 5 secs");

#clear the counter
Helper::clear_counter( $counter_file);

#should not be retried
$svc->foo( status => '408' );

$retries = Helper::get_counter( $counter_file );
is( $retries, 1, "408 - tried once" );


#clear the counter
Helper::clear_counter( $counter_file);

#Set the number of retries to 3
$svc->set_retries(3);

#Set retry interval to 2 seconds
$svc->set_retry_interval(2);


$svc->foo( status => '408' );

#get the retry counter
$retries = Helper::get_counter( $counter_file );
is($retries, 4, "408 - retried 3 times");

#clear the counter
Helper::clear_counter( $counter_file);

#retries is still 3
#should not be retried
$svc->foo( status => '503' );


#get the retry counter
$retries = Helper::get_counter( $counter_file );
is( $retries, 1, "503 - tried once" );

