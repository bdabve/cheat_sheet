# <center> MySQL and PHP</center>

## Creating lib file to connect to database with PDO

```sql
class Cookbook
{
  public static $host_name = "localhost";
  public static $db_name = "cookbook";
  public static $user_name = "user";
  public static $password = "pass";

  # Establish a connection to the cookbook database, returning a database
  # handle.  Raise an exception if the connection cannot be established.
  # In addition, cause exceptions to be raised for errors.

  public static function connect ()
  {
    $dsn = "mysql:host=" . self::$host_name . ";dbname=" . self::$db_name;
    $dbh = new PDO ($dsn, self::$user_name, self::$password);
    $dbh->setAttribute (PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return ($dbh);
  }

} # end Cookbook
```

## Encoding special characters using PHP

* The `htmlspecialchars()` and `urlencode()` functions perform HTML-encoding and URL-encoding.

  ```php
  require_once Cookbook.php

  $dbh = Cookbook::connect ();

  $stmt = "SELECT phrase_val FROM phrase ORDER BY phrase_val";
  $sth = dbh->query($stmt);

  while (list($phrase) = $sth->fetch (PDO::FETCH_NUM)) {
    # URL-encode the phrase value for use in the URL
    $url = "/var/www/html/mysearch.php?phrase=" . urlencode ($phrase);
    # HTML-encode the phrase value for use in the link label
    $label = htmlspecialchars($phrase);
    printf('<a href="%s">%s</a><br />', $url, $label);
  }
  ```

## Displaying Query Results as Paragraphs

```sql
require_once Cookbook.php

$dbh = Cookbook::connect ();

$sth = $dbh->query("SELECT NOW(), VERSION(), DATABASE()");
list($now, $version, $db) =  $sth->fetch(PDO::FETCH_NUM);
if ($db === NULL) $db = "NONE";
$para = "Local time on the MySQL server is $now.";
print("<p>" . htmlspecialchars($para) . "</p>");

$para = "The server version is $version.";
print("<p>" . htmlspecialchars($para) . "</p>");

$para = "The default database is $db.";
print("<p>" . htmlspecialchars($para) . "</p>");
```

## Displaying Query Results as Lists

* Ordered List

  ```php
  function make_ordered_list ($items, $encode = TRUE)
  {
    $result = "";
    foreach ($items as $val) {
      if ($encode)
      $val = htmlspecialchars ($val);
      $result .= "<li>$val</li>";
    }
    return ("<ol>$result</ol>");
  }
  # fetch items for list
  $stmt = "SELECT item FROM ingredient ORDER BY id";
  $sth = $dbh->query ($stmt);
  $items = $sth->fetchAll (PDO::FETCH_COLUMN, 0);

  # generate HTML list
  print (make_ordered_list ($items));
  ```

* Definition lists

  ```php

  include_once 'Cookbook.php';

  $conn = Cookbook::connect ();

  $stmt = "SELECT note, mnemonic FROM doremi ORDER BY id";
  $result = $conn->query($stmt);
  $terms = array();
  $defs = array();

  while (list($note, $mnemonic) = $result->fetch (PDO::FETCH_NUM)) {
      $terms[] = $note;
      $defs[] = $mnemonic;
  }
  print (make_definition_list($terms, $defs));

  function make_definition_list($terms, $definitions, $encode = TRUE){
      $result = "";
      $n = count ($terms);
      for ($i = 0; $i < $n; ++$i){
          $term = $terms[$i];
          $definition = $definitions[$i];
          if ($encode){
              $term = htmlspecialchars($term);
              $definition = htmlspecialchars($definition);
          }
          $result .= "<dt>$term</dt><dd>$definition</dd>";
      }
      return ("<dl>$result</dl>");
  }
  ```
