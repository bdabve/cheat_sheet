#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Wednesday 14-11-2018
 *
*/

$host = 'localhost';
$user = 'dabve';
$pass = 'mikeBand18';
$db = 'lpmj';

 
$conn = mysqli_connect("$host", "$user", "$pass", "$db");
if (mysqli_connect_errno()) {
    echo "[-] Error: " . mysqli_connect_error();
    exit();
}

/*  
 *------------------------------------
 *  Insert statement
 *------------------------------------

// Preparing our statement
$stmt = mysqli_prepare($conn, "INSERT INTO cats VALUES(?, ?, ?, ?)");

// Bind parameters
$id = 11;
$family = 'Chien';
$name = 'Chouchou';
$age = 1;

mysqli_stmt_bind_param($stmt, "issi", $id, $family, $name, $age);

// Executing our stmt
mysqli_stmt_execute($stmt);
printf("%d Row Inserted. \n", mysqli_stmt_affected_rows($stmt));
mysqli_stmt_close($stmt);
 */

/* 
 * ---------------------------------
 * Update Statement
 * ---------------------------------
$stmt = mysqli_prepare($conn, 'UPDATE cats SET name = ? WHERE id = ?');

$name = 'Choucho';
$id = 10;
mysqli_stmt_bind_param($stmt, 'si', $name, $id);
mysqli_stmt_execute($stmt);
printf('%d Row Updated', mysqli_stmt_affected_rows($stmt));
mysqli_stmt_close($stmt);
*/

/*
 * ---------------------------------------------
 *  Delete Statement
 * ---------------------------------------------
 *
$stmt = mysqli_prepare($conn, 'DELETE FROM cats WHERE id = ?');

$id = 4;
mysqli_stmt_bind_param($stmt, 'i', $id);
mysqli_stmt_execute($stmt);
printf('%d Row Deleted.', mysqli_stmt_affected_rows($stmt));
mysqli_stmt_close($stmt);

*/

/*
 * ---------------------------------------------
 *  Select Statement With MYSQLI_ASSOC
 * ---------------------------------------------
*/

$query = "SELECT * FROM users";
$result = mysqli_query($conn, $query);

if (!$result) {
    echo "[-] Error: " . mysqli_error($conn);
} else {
    $rows = mysqli_num_rows($result);
}

echo "\n[*] Query Data with MYSQLI_ASSOC \n\n";
echo '';
if ($rows) {
    for ($i = 0; $i < $rows; ++$i) {
        mysqli_data_seek($result, $i);
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
        echo "[+] forename      : " . $row['forename'] . "\n";
        echo "[+] surname       : " . $row['surname'] . "\n";
        echo "[+] username      : " . $row['username'] . "\n";
        echo "[+] password      : " . $row['password'] . "\n";
        echo "------------------------------------------------------\n";
    }
}


/*
 * ---------------------------------------------
 *  Select Statement With MYSQLI_NUM
 * ---------------------------------------------
 */

$query = "SELECT * FROM users";
$result = mysqli_query($conn, $query);

if (!$result) {
    echo "[-] Error: " . mysqli_error($conn);
} else {
    $rows = mysqli_num_rows($result);
}

echo "\n[*] Query Data with MYSLI_NUM \n\n";
if ($rows) {
    for ($i = 0; $i < $rows; ++$i) {
        mysqli_data_seek($result, $i);
        $row = mysqli_fetch_array($result, MYSQLI_NUM);
        for ($k = 0; $k < 4; ++$k)
        echo "[+] : " . $row[$k] . "\n";
        echo "------------------------------------------------------\n";
    }
}

// Close Statement
mysqli_close($conn);
?>

