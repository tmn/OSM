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

open FILE, ">buss.sql";
print FILE "SET SQL_MODE=\"NO_AUTO_VALUE_ON_ZERO\";\n";
print FILE "/*!40101 SET \@OLD_CHARACTER_SET_CLIENT=\@\@CHARACTER_SET_CLIENT */;\n";
print FILE "/*!40101 SET \@OLD_CHARACTER_SET_RESULTS=\@\@CHARACTER_SET_RESULTS */;\n";
print FILE "/*!40101 SET \@OLD_COLLATION_CONNECTION=\@\@COLLATION_CONNECTION */;\n\n";
print FILE "INSERT INTO `gjensidige_options` (`id`, `name`, `lat`, `lon`) VALUES";
foreach (@stuff) {
	my $name = $_->{name};
	$name =~ s/\'/\&apos;/;
	print FILE "('" . $_->{id} . "', '" . $name . "', '" . $_->{latitude} . "', '" . $_->{longitude} . "'),\n";
}
close FILE;