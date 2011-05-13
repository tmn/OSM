#!/usr/bin/perl -w

# not tested
# buggy I think

use utf8;
use strict;

use Mysql;
use JSON;

my $conf['host']	= '';
my $conf['user']	= '';
my $conf['pass']	= '';
my $conf['tabl']	= '';
my $conf['db']		= '';

my $connect = Mysql->connect($conf['host'], $conf['db'], $conf['user'], $conf['pass']);
$connect->selectdb($conf['db']);

my $file;
my $content;
my $sql;

open FILE, "<atb";
$file = do { local $/; <FILE> };
close FILE;

$content = from_json($file);

my @stuff = @{ $content->{stops} };

foreach (@stuff) {
	my $name = $_->{name};
	$name =~ s/\'/\&apos;/;
	$sql = "INSERT INTO " . $conf['table'] . " (id, name, lat, lon) VALUES ('" . $_->{id} . "', '" . $name . "', '" . $_->{latitude} . "', '" . $_->{longitude} . "')";
	$execute = $connect->query($sql);
}
