#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Wednesday 14-11-2018
 *
*/

$db_host = "localhost";
$db_user = 'dabve';
$db_pass = 'mikeBand18';
$db_name = 'shop';

$conn = mysqli_connect("$db_host", "$db_user", "$db_pass", "$db_name");
if (mysqli_connect_errno()) echo "[-] Failed To Connect: \n" . mysqli_connect_error();


$query = "CREATE TABLE IF NOT EXISTS cats(
  id SMALLINT NOT NULL AUTO_INCREMENT,
  family VARCHAR(32) NOT NULL,
  name VARCHAR(32) NOT NULL,
  age TINYINT NOT NULL,
  PRIMARY KEY(id)
)";

$result = mysqli_query($conn, $query);
if (!$result) echo "Failed to add table" . mysqli_connect_error();

mysqli_close($conn);
?>
