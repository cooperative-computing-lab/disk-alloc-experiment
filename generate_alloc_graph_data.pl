#!/usr/bin/perl
#
#Copyright (C) 2016- The University of Notre Dame
#This software is distributed under the GNU General Public License.
#This program analyzes the raw data from the create/delete overhead
#tests and provides the median, median absolute deviation, mean, and
#standard deviation for that data. This finalized data is used for graphing.
#This program requires the user to specify the raw data file to be analyzed 
#and the pattern for the output file. This output pattern will have '.dat' 
#appended to it.
#

use strict; 
use Scalar::Util qw(looks_like_number);
use Math::Complex;

my $num_args = $#ARGV + 1;
if($num_args ne 2) {
	print "Must specify input data file and output file.\n";
	exit 1;
}

my $size=0;
my $files;
my $alloc_size = "2GB";
my $test_time = "?";
my $test_size = "?";
my $num_files = "10000";
my $nest_depth = "?";
my $read_test = "?";
my $write_test = "?";
my $alloc_int = 0;
my @read = ();
my @write = ();
my $r = 0;
my $w = 0;
my $read_average_time = 0.0;
my $read_standard_deviation = 0.0;
my $write_average_time = 0.0;
my $write_standard_deviation = 0.0;
my $read_med = 0;
my $read_mad = 0;
my $write_med = 0;
my $write_mad = 0;
my $in = $ARGV[0];
my $out_arg = $ARGV[1];
my $append_size = "";
my $out = "";
my $i;
open(INPUT, $in);

	my @values = ();
	my $lines = 0;
	while (my $line = <INPUT>) {
		chomp $line;
		my @parts = split(" ",$line);

		if($lines eq 0) {
			$alloc_size = $parts[0];
			$test_size = $parts[3];
		}

		if($parts[0] ne $alloc_size) {

			#Calculate Average, Standard Deviation for given size at given nest depth. Save result to file.
			my $read_avg_time = 0.0;
			my $read_std_dev = 0.0;
			foreach my $time (@read) {
				$read_avg_time += $time * 1.0;
			}
			$read_avg_time = $read_avg_time / $r;
			$read_average_time = $read_avg_time / 1000000;
			foreach my $time (@read) {
				$read_std_dev += ($time - $read_avg_time) ** 2;
				$i++;
			}
			$read_std_dev = $read_std_dev / $i;
			$read_standard_deviation = sqrt($read_std_dev) / 1000000;
			$i = 0;
			my @sort_read = sort {$a <=> $b} @read;
			my @abs_read;
			$read_med = @sort_read[10];
			foreach my $time (@sort_read) {
				$time = abs($time - $read_med);
			}
			@abs_read = sort {$a <=> $b} @sort_read;
			$read_mad = @abs_read[10] / 1000000;
			$i = 0;
			$read_med = $read_med / 1000000;

			my $write_avg_time = 0.0;
			my $write_std_dev = 0.0;
			foreach my $time (@write) {
				$write_avg_time += $time * 1.0;
			}
			$write_avg_time = $write_avg_time / $w;
			$write_average_time = $write_avg_time / 1000000;
			foreach my $time (@write) {
				$write_std_dev += ($time - $write_avg_time) ** 2;
				$i++;
			}
			$write_std_dev = $write_std_dev / $i;
			$write_standard_deviation = sqrt($write_std_dev) / 1000000;
			$i = 0;
			my @sort_write = sort {$a <=> $b} @write;
			my @abs_write;
			$write_med = @sort_write[10];
			foreach my $time (@sort_write) {
				$time = abs($time - $write_med);
			}
			@abs_write = sort {$a <=> $b} @sort_write;
			$write_mad = @abs_write[10] / 1000000;
			$i = 0;
			$write_med = $write_med / 1000000;

			$out = $out_arg . ".dat";
			open(FILE, ">>$out");
			print FILE "$alloc_size 0 ? $test_size $read_med $read_mad $alloc_int\n$alloc_size ? 0 $test_size $write_med $write_mad $alloc_int\n";
			close(FILE);
			$r = 0;
			$w = 0;
			$alloc_size = $parts[0];
			$test_size = $parts[3];
		}

		if($parts[1] eq 0) {
			$read[$r] = $parts[4];
			$r++;
		}
		elsif($parts[2] eq 0) {
			$write[$w] = $parts[4];
			$w++;
		}
		$lines++;
	}

$i = 0;
my @sort_read = sort {$a <=> $b} @read;
my @abs_read;
$read_med = @sort_read[10];
foreach my $time (@sort_read) {
	$time = abs($time - $read_med);
}
@abs_read = sort {$a <=> $b} @sort_read;
$read_mad = @abs_read[10] / 1000000;
$i = 0;
$read_med = $read_med / 1000000;
my @sort_write = sort {$a <=> $b} @write;
my @abs_write;
$write_med = @sort_write[10];
foreach my $time (@sort_write) {
	$time = abs($time - $write_med);
}
@abs_write = sort {$a <=> $b} @sort_write;
$write_mad = @abs_write[10] / 1000000;
$i = 0;
$write_med = $write_med / 1000000;

open(FILE, ">>$out");
print FILE "$alloc_size 0 ? $test_size $read_med $read_mad $alloc_int\n$alloc_size ? 0 $test_size $write_med $write_mad $alloc_int\n";
close(FILE);
close(INPUT);
