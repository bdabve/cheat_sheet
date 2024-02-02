#!/usr/bin/php
<?php
/*
 *
 *        AUTHOR: dabve in Lenovo
 *       CREATED: Monday 03-12-2018
 *
*/

$db_user = 'dabve';
$db_pass = 'mikeBand18';

try {
    $pdo_options[PDO::ATTR_ERRMODE] = PDO::ERRMODE_EXCEPTION;
    $conn = new PDO('mysql:host=localhost;dbname=cookbook; charset=utf8', "$db_user", "$db_pass", $pdo_options);
} catch (Exception $e){
    die('Error: ' . $e->getMessage());

}

$query = "CREATE TABLE IF NOT EXISTS money(amt INT, name VARCHAR(30)) ENGINE=InnoDB";
$result = $conn->exec($query);

// $conn->exec("INSERT INTO money(amt, name) VALUES(10, 'Eve'), (0, 'Ida')");
// echo "Done adding new records";

try {
    $conn->beginTransaction();
    $conn->exec("UPDATE money SET amt = amt + 6 WHERE name = 'Eve'");
    $conn->exec("UPDATE money SET amt = amt + 6 WHERE name = 'Ida'");
    $conn->commit();
    print("[+] All Changes Committed successfully");
} catch (Exception $e) {
    print("[-] Transaction failed, rolling back.\n[-] Error was:");
    print($e->getMessage() . "\n");
    try {
        $conn->rollBack();
    } catch (Exception $e2) { }
}
?>

