<?php
# this script not to execute it's like a cheat_sheet for PHP PDO
# connect to database
try {

    # On se connecte à MySQL
    $pdo_options[PDO::ATTR_ERRMODE] = PDO::ERRMODE_EXCEPTION;
    $bdd = new PDO('mysql:host=localhost;dbname=test', 'root', '', $pdo_options);
    # OR
    $dsn = "mysql:host=localhost;dbname=db_name";
    $dbh = new PDO($dsn, "username", "password");
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    print('Connected')

} catch (PDOException $e) {
    print ("Cannot connect to server\n");
    print ('Error code: ', $e->getCode() . "\n");
    print ("Error Message: ", $e->getMessage() . "\n");
}


# using library file with utility method for connecting to MySQL
class Cookbook {
    public static $host_name = "localhost";
    public static $db_name = "cookbook";
    public static $user_name = "username";
    public static $passwd = "password";

    public static function connect(){
        # connect to database
        # if all your work goes here declare this function as private not static
        $dsn = "mysql:host=" . self::$host_name . ";dbname=" . self::$db_name;
        $dbh = new PDO($dsn, self::$user_name, self::$passwd);
        $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return ($dbh);
    }
}

try {
    $dbh = Cookbook::connect();
    print('Connected');
} catch(PDOException $e) {
    print($e->getCode() . " => " . $e->getMessage());
    exit(1);
}

# ---------------------
# Executing statement
# ---------------------
# PDO has two connection-object methods to execute SQL statements: 
#   - 'exec()' for statements that do not return a result set.
#   - 'query()' for those that do. 
# If you have PDO exceptions enabled, both methods raise an exception if statement execution fails.
# ------------------------------------------------------------------------------------------------
#
# PDO::FETCH_NUM   : returns an array with elements accessed using numeric subscripts, beginning with 0. 
#                   The array size indicates the number of result set columns.
# PDO::FETCH_ASSOC : returns an associative array containing values accessed by column name ($row["id"], $row["name"], $row["cats"]).
# PDO::FETCH_OBJ   : returns an object having members accessed using the column names ($row->id, $row->name, $row->cats).
# PDO::FETCH_BOTH  : which is like a combination of 'PDO::FETCH_NUM' and 'PDO::FETCH_ASSOC'. 
#
# To set the default fetch mode for all statements executed within a connection, use the setAttribute database-handle method:
# $dbh->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
#
# To set the mode for a given statement, call its 'setFetchMode()' method after executing the statement and before fetching the results:
# $sth->setFetchMode (PDO::FETCH_OBJ);
#
# -------------------------------------
# It’s also possible to use a statement handle as an iterator. The handle uses the current default fetch mode:
#   $sth->setFetchMode(PDO::FETCH_NUM);
#   foreach ($sth as $row)
#       printf ("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);
#
# --------------------------------------------------------------------------
# The 'fetchAll()' method fetches and returns the entire result set as an array of rows. It permits an optional fetch-mode argument:
#   $rows = $sth->fetchAll (PDO::FETCH_NUM);
#   foreach ($rows as $row)
#       printf ("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);

try {
    $reponse = $bdd->query('SELECT * FROM jeux_video');
    # Display all records
    while ($donnees = $reponse->fetch()){ 
        echo $donnees['nom'];
        echo $donnees['possesseur'];
        echo $donnees['prix'];
    } 
    $reponse->closeCursor(); # Close the cursor
} catch(Exception $e) {
    die('Erreur : '.$e->getMessage()); # Display error Message
} 

try {
    $sth = $dbh->query("SELECT id, name, cats FROM profile");
    $count = 0;
    while ($row = $sth->fetch(PDO::FETCH_NUM)) {
        printf("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);
        $count++;
    }
    printf("Number of rows returned: %d", $count);
}
# handle statement error
try {
    $dbh->query("SELECT");  # malformed query
} catch (PDOException $e) {
    print("SQLSTATE value: " . $e->getCode() . "\n");
    print("Error message: " . $e->getMessage() . "\n");

    print("Error information using database handle:\n");
    print("Error code: " . $dbh->errorCode() . "\n");
    $error_info = $dbh->errorInfo();
    print_r($error_info);
}

# catch errors
$conn = new PDO('mysql:host=localhost;dbname=test;charset=utf8', 'root', '', array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
$result = $conn->query('SELECT nom FROM jeux_video') or die(print_r($bdd->errorInfo()));

# ---------------------
# Prepared Statement
# ---------------------
try {
    $pdo_options[PDO::ATTR_ERRMODE] = PDO::ERRMODE_EXCEPTION;
    $bdd = new PDO('mysql:host=localhost;dbname=test', 'root', '', $pdo_options);

    # make request
    $req = $bdd->prepare('SELECT nom, prix FROM jeux_video WHERE possesseur = ? AND prix <= ? ORDER BY prix');
    $req->execute(array($_GET['possesseur'], $_GET['prix_max']));
    while ($donnees = $req->fetch()) {
        echo $donnees['nom'] . ' (' . $donnees['prix'] . ' EUR)';
    }
    // Marquery nominatifs
    // $req = $bdd->prepare('SELECT nom, prix FROM jeux_video WHERE possesseur = :possesseur AND prix <= :prixmax');
    // $req->execute(array('possesseur' => $_GET['possesseur'], 'prixmax' => $_GET['prix_max']));

    $req->closeCursor();
} catch(Exception $e) {
    die('Erreur : '.$e->getMessage());
}


# ---------------------
# Null Values
# ---------------------
$sth = $dbh->query("SELECT name, birth, foods FROM profile");
while ($row = $sth->fetch(PDO::FETCH_NUM)) {
    foreach(array_keys($row) as $key) {
        if( $row[$key] === NULL) $row[$key] = "NULL";       # An alternative to === for NULL value tests is 'is_null()'.
    }
    print("name: $row[0], birth: $row[1], foods: $row[2]\n");
}

# -----------------------------------------------------------
# Last Insert ID
# ---------------
$dbh->exec("INSERT INTO profile(name, job) VALUES('moth', 'hdw')");
$seq = $dbh->lastInsertId();

# -------------------------------------------------------------------
# Working with metadata
# ----------------------

$stmt = "SELECT name, birth FROM profile";
print("Statement: $stmt\n");
$sth = $dbh->prepare($stmt);        # dbh = db_handler; sth = statement handler
$sth->execute();

# metadata information becomes available at this point...
$ncols = $sth->columnCount();
print("Number of columns: $ncols\n");
for ($i = 0; $i < $ncols; $i++) {
    $col_info = $sth->getColumnMeta ($i);
    $flags = implode (",", array_values ($col_info["flags"]));
    printf ("--- Column %d (%s) ---\n", $i, $col_info["name"]);
    printf ("pdo_type: %d\n", $col_info["pdo_type"]);
    printf ("native_type: %s\n", $col_info["native_type"]);
    printf ("len: %d\n", $col_info["len"]);
    printf ("precision: %d\n", $col_info["precision"]);
    printf ("flags: %s\n", $flags);
    printf ("table: %s\n", $col_info["table"]);
}

# ---------------------------------------------------------
# Usefull scripts
# ----------------------
# List table in a specific database
# we create a function to do that
require_once "Cookbook.php";
# echo <<<_END like """""" in python
echo <<<_END             
    <html>
    <head><title>Table in cookbook database</title></head>
    <body>
    <p>Tables in cookbook database:</p>
_END;
$dbh = Cookbook::connect();
$stmt = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'cookbook' ORDER BY TABLE_NAME";
$sth = $dbh->query($stmt);
while ( list($tbl_name) = $sth->fetch(PDO::FETCH_NUM))
    print($tbl_name . "<br />");
$dbh = NULL;

echo "</body></html>";
# ---------------------------------------------------------
# Encoding Special Chars
# ----------------------
# 'htmlspecialchars()' and 'urlencode()' functions perform HTMLencoding and URL-encoding. Use them as follows:
$stmt = "SELECT phrase_val FROM phrase ORDER BY phrase_val";
$sth = $dbh->query ($stmt);
while (list ($phrase) = $sth->fetch (PDO::FETCH_NUM)) {
    # URL-encode the phrase value for use in the URL
    $url = "/mcb/mysearch.php?phrase=" . urlencode ($phrase);
    # HTML-encode the phrase value for use in the link label
    $label = htmlspecialchars ($phrase);
    printf ('<a href="%s">%s</a><br />', $url, $label);
}

# ---------------------------------------------------------
# usefull functions
# ----------------------
# Displaying Query Results as Paragraphs
$sth = $dbh->query ("SELECT NOW(), VERSION(), DATABASE()");
list($now, $version, $db) = $sth->fetch(PDO::FETCH_NUM);           # multiple assignement
if ($db === NULL)
    $db = "NONE";
$para = "Local time on the MySQL server is $now.";
print("<p>" . htmlspecialchars($para) . "</p>");
$para = "The server version is $version.";
print ("<p>" . htmlspecialchars($para) . "</p>");
$para = "The default database is $db.";
print ("<p>" . htmlspecialchars($para) . "</p>");

# Displaying Query Results as Lists
function make_ordered_list ($items, $encode=TRUE) {
    $result = "";
    foreach ($items as $val) {
        if ($encode)
            $val = htmlspecialchars($val);
        $result .= "<li>$val</li>";
    }
    return ("<ol>$result</ol>");
}
# To use the utility function, fetch the data and print the HTML like so:
# fetch items for list
$stmt = "SELECT item FROM ingredient ORDER BY id";
$sth = $dbh->query($stmt);
$items = $sth->fetchAll(PDO::FETCH_COLUMN, 0);
# generate HTML list
print (make_ordered_list ($items));
?>
