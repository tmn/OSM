#!/usr/bin/perl -w

use strict;
use utf8;

use JSON;

my $file;
my $content;

open FILE, "<atb";
$file = do { local $/; <FILE> };
close FILE;

$content = from_json($file);

my @stuff = @{ $content->{stops} };

open FILE, ">buss_minified_with_alf.xml";
print FILE "<?xml version='1.0' standalone='no'?>";
print FILE "<osm>";
foreach (@stuff) {
	my $name = $_->{name};
	$name =~ s/\'/\&apos;/;
	print FILE "<node lat='" . $_->{latitude} . "' lon='" . $_->{longitude} . "'>";
	print FILE "<tag v='" . $name  . "'/>";
	print FILE "</node>";
}
print FILE "</osm>";
close FILE;
print "Antall holdeplasser: " . @stuff . "\n\n";