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
if ( mysqli_connect_errno() ) {
    echo "[-] Failed To Connect: \n[-] " . mysqli_connect_error() . "\n";
    exit();
} else echo "[+] Connection Success";


$query1 = "INSERT INTO cats VALUES(2, 'chien', 'chouo', 1)";
if ( ! $result = mysqli_query($conn, $query1))  echo "[-] Failed to add query.\n[-] " . mysqli_error($conn);

$query2 = "INSERT INTO cats VALUES(3, 'chat', 'chouchou', 6)";
if ( ! $result = mysqli_query($conn, $query2))  echo "[-] Failed to add query.\n[-] " . mysqli_error($conn);

$query3 = "INSERT INTO cats VALUES(4, 'tortue', 'facroun', 3)";
if ( ! $result = mysqli_query($conn, $query3))  echo "[-] Failed to add query.\n[-] " . mysqli_error($conn);

mysqli_close($conn);

?>
