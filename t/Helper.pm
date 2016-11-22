#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use Data::Dumper;
use JSON;

package Helper;



sub get_counter {
    
    my $counter_file = shift;

     my $json_text = do {
         warn ( $counter_file );
         open(my $fh, "<:encoding(UTF-8)", $counter_file) or die("Can't open \$counter_file\": $!\n");
         local $/;
         <$fh>
     };
     
     my $json = JSON->new;
     my $data = $json->decode($json_text);
     
     my $retries = $data->{'retries'};

     return $retries;

}

sub clear_counter {

    my $counter_file = shift;

    my $json = JSON->new;
    my $data = {};
    $data->{'retries'} = 0;
    
    open( my $fh, ">$counter_file");
    print $fh $json->encode($data) . "\n";
    close( $fh );
    
}

sub increment_counter {

    my $counter_file = shift;

    my $retries = get_counter( $counter_file );
    my $json = JSON->new;
    my $data = {};
    
    $data->{'retries'} = $retries + 1;
    open( my $fh, ">$counter_file");
    print $fh $json->encode($data) . "\n";
    close( $fh );
    
}

1;
