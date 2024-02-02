#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Tuesday 13-11-2018
 *
*/

$db_host = "localhost";
$db_user = 'dabve';
$db_pass = 'mikeBand18';
$db_name = 'shop';

$conn = mysqli_connect("$db_host", "$db_user", "$db_pass", "$db_name");
if (mysqli_connect_errno()) echo "[-] Failed To Connect: \n" . mysqli_connect_error();

$query = "SELECT * FROM users";
$result = mysqli_query($conn, $query);
$rows = mysqli_num_rows($result);
if ($rows) {

    for ($i = 0; $i < $rows; ++$i){
        mysqli_data_seek($result, $i);
        echo "[+] User id           : " . mysqli_fetch_assoc($result)['user_id'] . "\n";
        mysqli_data_seek($result, $i);
        echo "[+] User Name         : " . mysqli_fetch_assoc($result)['username'] . "\n";
        mysqli_data_seek($result, $i);
        echo "[+] Email             : " . mysqli_fetch_assoc($result)['email'] . "\n";
        mysqli_data_seek($result, $i);
        echo "[+] Full Name         : " . mysqli_fetch_assoc($result)['fullname'] . "\n";
        mysqli_data_seek($result, $i);
        echo "[+] Registrated Date  : " . mysqli_fetch_assoc($result)['reg_date'] . "\n";
        echo "---------------------------------------------\n";
    }
}
?>

