#!/usr/bin/php
<?php
/*
 *-------------------------------------------------------
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Monday 12-11-2018
 * This plug-in inserts a record into a Mysql database
 * If the database table does not already exist, it create it first
 * Upon success, a value of 1 is returned.
 * Otherwise, -1 is returned if the insert failed, or -2 if the handle already exists
 * Arguments:
       * $table     = The name of the data table
       * $nmax      = The maximum length allowed for $name
       * $hmax      = The maximum length allowed for $handle
       * $salt1     = Semi-random string to help secure the password
       * $salt2     = A second string to go with $salt1
       * $name      = The user's full name to add to the database
       * $handle    = The user's username
       * $pass      = The user's password
       * $email     = The user's e-mail address
 *-------------------------------------------------------
*/

$db_host = 'localhost';
$db_name = 'php_plug_in';
$db_user = 'dabve';
$db_pass = '';

$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);
if (mysqli_connect_errno($conn)) echo "[-] Failed to connect to MySQL\n[-] " . mysqli_connect_error();

$table = 'Users';   // Table Name
$nmax = 32;         // Maximum number of characters allowed in the string name 
$hmax = 16;         // Maximum number of characters allowed in the string handle 
$name = 'Mohammed Znanda';
$handle = 'Zendoud';
$pass = '123123';
$email = 'Znanda@gmail.com';

// Random strings to help make it next to impossible to deduce a password
$salt1 = 'F^&fg';
$salt2 = '9*hz!';

function add_user_to_db($table, $nmax, $hmax , $salt1, $salt2, $name, $handle, $pass, $email) {
    global $conn;
    $query = "CREATE TABLE IF NOT EXISTS $table(
        name VARCHAR($nmax), 
        handle VARCHAR($hmax),
        pass CHAR(32),
        email VARCHAR(255),
        INDEX(name(6)),
        INDEX(handle(6)),
        INDEX(email(6)))";

    $result = mysqli_query($conn, $query);
    if (!$result) die($conn->error);
    
    $query = "SELECT * FROM $table WHERE handle='$handle'";
    $result = mysqli_query($conn, $query);
    if ( mysqli_num_rows($result) == 1 ) return -2;

    $pass = md5($salt1 . $pass . $salt2);
    $query = "INSERT INTO $table VALUES('$name', '$handle', '$pass', '$email')";
    $result = mysqli_query($conn, $query);
    if ( $result ) return 1;
    else return -1;

    mysqli_close($conn);
}

$result = add_user_to_db($table, $nmax, $hmax, $salt1, $salt2, $name, $handle, $pass, $email);
/*
 * if this is the first record to add, then a table with the name in $table will be created
 * if the insert was successful, $result will now contain a value of 1, 
 * otherwise, it will be -1 if the insert failed
 * or -2 if a record containing the string in $handle already exists in the database.
*/

if ($result == -2) echo "[-] The handle '$handle' already exists.\n[-] Please choose a defferent handle. \n";
elseif ($result == 1) echo "[+] User '$name' successfully added. \n";
else echo "[-] Failed to add user '$name' \n";

?>
