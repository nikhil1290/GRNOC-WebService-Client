#!/usr/bin/perl

use Test::More tests => 2;

use strict;
use warnings;

use FindBin;
use GRNOC::WebService::Client;
use Data::Dumper;

# Testing that auth failure triggers trying subsequent locations
my $svc = GRNOC::WebService::Client->new(
                                         service_name => 'urn:publicid:IDN+grnoc.iu.edu:GlobalNOC:AuthFailover:1:Data',
                                         service_cache_file => $FindBin::Bin . '/conf/name_service.xml'
                                        );

$svc->set_credentials(uid    => "dummy",
		      passwd => "apple",
		      realm  => "The Realm"
		      );

my $result = $svc->test();

ok(defined $result, "was able to get a result");

ok($result->{'results'}->{'success'} eq 2, "got expected output");

