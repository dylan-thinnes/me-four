#!/usr/bin/perl
use strict;
use warnings;

while (my $line = <STDIN>) {
    if($line =~ m/^(.*)<%=(.*)\%>(.*)$/) {
        my $command = "bash -c '" . $2 . "'";
        my $output = qx($command);
        chomp $output;
        print "$1$output$3\n";
    } else {
        print "$line"
    }
}
