#!/usr/bin/env perl
#
# Educational Purpose :
# Sthack 2016
# Annual Project 4ASI1 Grp nb*3 ESGI
#
use strict;
use warnings qw(all);

use Carp qw(croak);
use Fcntl qw(:DEFAULT);

unless(@ARGV) {
	print "$0 - Converts rtl_sdr output to GNU Radio cfile (little-endian)\n";
	print "Usage: $0 dump1.dat dump2.dat > combined.cfile\n";
}

binmode \*STDOUT;
for my $filename(@ARGV) {
	sysopen(my $fh, $filename, O_RDONLY)
	|| croak "Can't open $filename: $!";
	my $buf;
	while(sysread($fh, $buf, 4096)) {
		print pack('f<*', map{ ($_ - 127) * (1 / 128) } unpack('C*', $buf));
	}
	close $fh;
}
