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

open FILE, ">buss.xml";
print FILE "<?xml version='1.0' standalone='no'?>\n";
print FILE "<osm>\n";
foreach (@stuff) {
	my $name = $_->{name};
	$name =~ s/\'/\&apos;/;
	print FILE "<node id='" . $_->{id} . "' lat='" . $_->{latitude} . "' lon='" . $_->{longitude} . "'>\n";
	print FILE "<tag k='name' v='" . $name  . "'/>\n";
	print FILE "</node>\n\n";
}
print FILE "</osm>";
close FILE;
print "Antall holdeplasser: " . @stuff . "\n\n";