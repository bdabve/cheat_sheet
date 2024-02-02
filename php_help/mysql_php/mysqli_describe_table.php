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

$query = "DESCRIBE cats";
$result = mysqli_query($conn, $query);
if ( !$result ) echo "Database access failed: " . mysqli_error();

$rows = mysqli_num_rows($result);
for ($j = 0; $j < $rows; ++$j){
  mysqli_data_seek($result, $j);
  $row = mysqli_fetch_array($result, MYSQLI_NUM);
  for ($k = 0; $k < 6; ++$k) echo $row[$k] . "\n";
}

?>
