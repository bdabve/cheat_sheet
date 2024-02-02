#!/usr/bin/php
<?php
/*
 *---------------------------------------------
 * AUTHOR: dabve in Lenovo
 * CREATED: Tuesday 13-11-2018
 * This plug_in retrieves a user's details and returns them
 * Upon success, it returns a two-element array with the first element having the value TRUE 
 * The second being an array containing the user's details 
 * On failure, it returns a single-element array with the value FALSE.
 * Arguments
     * $table   : The name of the data table
     * $handle  : The user's username
 *---------------------------------------------
*/

$db_host = 'localhost';
$db_user = 'dabve';
$db_pass = '';
$db_name = 'php_plug_in';

$conn = mysqli_connect("$db_host", "$db_user", "$db_pass", "$db_name");
if (mysqli_connect_errno($conn)) echo "[-] Failed to connect to MySQL\n [-]" . mysqli_connect_error() ; 

function get_user_from_db($table, $handle) {
    global $conn;
    $query = "SELECT * FROM $table WHERE handle = '$handle'";
    $result = mysqli_query($conn, $query);
    if ( mysqli_num_rows($result) == 0 ) return array(FALSE);
    else return array(TRUE, mysqli_fetch_array($result, MYSQLI_NUM));
}


$table = 'Users';
$handle = 'Meziane';

$result = get_user_from_db($table, $handle);    // if $result[0] is FALSE, then user does not exists, else $result[0] will have a value
if ($result[0] == FALSE) echo "[-] Lookup failed.";
else echo "[*] Getting Data From DB...\n" .
          "[+] Name         = " . $result[1][0] . "\n" .
          "[+] Handle       = " . $result[1][1] . "\n" .
          "[+] Pass(salted) = " . $result[1][2] . "\n" .
          "[+] Email        = " . $result[1][3] . "\n";

?>
