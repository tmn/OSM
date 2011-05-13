<?php
/**
 * Just testing output
 */
$db['host']		= '';
$db['user']		= '';
$db['pass']		= '';
$db['tabl']		= '';
$db['db']		= '';


$con = mysql_connect($db['host'], $db['user'], $db['pass']);
mysql_select_db($db['db']);

$sql = "SELECT * FROM " . $db['tabl'];

$result = mysql_query($sql);

echo '<table>';
while ($row = mysql_fetch_array($result)) {
	echo '<tr>';
	printf("<td>Id</td><td>%s</td>", $row['id']);
	echo '</tr>';
	
	echo '<tr>';
	printf("<td>Name</td><td>%s</td>", $row['name']);
	echo '</tr>';
	
	echo '<tr>';
	printf("<td>Latitude</td><td>%s</td>", $row['lat']);
	echo '</tr>';
	
	echo '<tr>';
	printf("<td>Longitude</td><td>%s</td>", $row['lon']);
	echo '</tr>';
	
	echo '<tr><td> </td><td></td></tr>';
}
echo '</table>';