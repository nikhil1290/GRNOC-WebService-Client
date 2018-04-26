use Test::More tests => 4;

use strict;
use GRNOC::WebService::Client;
use Data::Dumper;
use FindBin;

my $config_file = $FindBin::Bin . '/conf/config.xml';

my $realm;

#pick realm from the config file
my $svc = GRNOC::WebService::Client->new( url => "http://localhost:8529/test.cgi",      
                                           config_file => $config_file );
                                            
ok(defined $svc ,"Creating new Client");
                                        
$svc->test();  

#verify default realm is set
$realm = $svc->get_realm();
is($realm, "foo", "Default realm is set");

#override default realm from config file
$svc = GRNOC::WebService::Client->new( url => "http://localhost:8529/test.cgi",
                                       realm => "bar" );

$svc->test();
$realm = $svc->get_realm();
is($realm, "bar", "Default realm overwrite");


#use the deafult realm
$svc = GRNOC::WebService::Client->new( url => "http://localhost:8529/test.cgi" );
                                     
$svc->test();

$realm = $svc->get_realm();
is($realm, undef, "Default realm overwrite");