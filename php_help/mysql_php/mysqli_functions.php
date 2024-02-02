#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Tuesday 13-11-2018
 *
*/

$host = "localhost";
$db = "lpmj";
$user_name = "dabve";
$password = "mikeBand18";

$conn = mysqli_connect("$host", "$user_name", "$password", "$db");
if (mysqli_connect_errno($conn)) echo "[-] Failed to connect to MySQL\n[-] " . mysqli_connect_error();

// print_r(mysqli_get_client_info($conn));         // It returns the MySQL client library version.

// var_dump(mysqli_get_charset($conn));         // It returns a character set object.

// print_r(mysqli_get_client_stats());          // It returns statistics about client per-process

echo "[+] " . mysqli_get_host_info($conn);           // It returns the MySQLi server hostname and the connection type.

$result = mysqli_query($conn, "SHOW TABLES");
print_r($result);


mysqli_close($conn);
?>
