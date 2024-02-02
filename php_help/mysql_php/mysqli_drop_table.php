#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Wednesday 14-11-2018
 *
*/

$host = "localhost";
$db = "shop";
$user_name = "dabve";
$password = "mikeBand18";

$conn = mysqli_connect("$host", "$user_name", "$password", "$db");
if (mysqli_connect_errno($conn)) echo "[-] Failed to connect to MySQL\n[-] " . mysqli_connect_error();

$query = ("DROP TABLE IF EXISTS cats");

if (! mysqli_query($conn, $query)) echo "[-] Error: " . mysqli_error();
?>
