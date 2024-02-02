# <center>Preventing Hacking Attempts</center>

## How to safely access MySQL with user input:

* `real_escape_string`: a function you can use that will remove any magic quotes added to a user-inputted string and then properly sanitize it for you. 
* `get_magic_quotes_gpc` function returns `TRUE` if magic quotes are active. In that case, any slashes that have been added to a string have to be removed, or the `real_escape_string` method could end up double-escaping some characters, creating corrupted strings.
    
  ```php
  <?php
       function mysql_fix_string($conn, $string)
       {
           if (get_magic_quotes_gpc()) $string = stripslashes($string);
           return $conn->real_escape_string($string);
       }
  ?>
  ```
* How to incorporate `mysql_fix_string` within your own code
  ```php
  <?php

    require_once 'login.php';
    $conn = new mysqli($hn, $un, $pw, $db);
    if ($conn->connect_error) die($conn->connect_error);

    $user = mysql_fix_string($conn, $_POST['user']);
    $pass = mysql_fix_string($conn, $_POST['pass']);
    $query = "SELECT * FROM users WHERE user='$user' AND pass='$pass'";

    // Etc...
    function mysql_fix_string($conn, $string)
    {
      if (get_magic_quotes_gpc()) $string = stripslashes($string);
      return $conn->real_escape_string($string);
    }

  ?>
  ```

## Using Placeholders:

```php
require_once 'login.php';
$conn = new mysqli($hn, $un, $pw, $db);
if ($conn->connect_error) die($conn->connect_error);


// Prepare statement
$stmt = $conn->prepare('INSERT INTO table_name VALUES(?,?,?,?,?)');

/* Execute the statement
 * It's use to bind some PHP variable to each of the question marks
 * i : The data is an integer.
 * d : The data is a double.
 * s : The data is a string.
 * b : The data is a BLOB(and will be sent in packets)
 */
$stmt->bind_param('sssss', $author, $title, $category, $year, $isbn)

$authot = 'Emily Bronte';
$title = 'Wuthering Heights';
$category = 'Classic Fiction';
$year = '1847';
$isbn = '9780553212587';

$stmt->execute();
printf("%d Row inserted.\n", $stmt->affected_rows);
$stmt->close();
$conn>close();
```

## Preventing HTML Injection:

* Therefore, if you are ever going to display anything that your users enter, either immediately or after storing it in a database, you need to first sanitize it using the **_htmlentities_** function. 
* To do this, I recommend that you create a new function, like the first one in this example, which can sanitize for both **_SQL_** and **_XSS_** injections.

* **_htmlentities_** function, which strips out all HTML markup codes and replaces them with a form that displays the characters, but does not allow a browser to act on them.
  
  ```php
  function mysql_entities_fix_string($conn, $string)
  {
    return htmlentities(mysql_fix_string($conn, $string));
  }

  function mysql_fix_string($conn, $string)
  {
    if (get_magic_quotes_gpc()) $string = stripslashes($string);
    return $conn->real_escape_string($string);
  }
  ```

* The `mysql_entities_fix_string` function first calls `mysql_fix_string` and then passes the result through `htmlentities` before returning the fully sanitized string. 
* To use either of these functions, you must already have an active connection object open to a `MySQL` database.


### How to safely access MySQL and prevent XSS attacks

```php
require_once 'login.php';
$conn = new mysqli($hn, $un, $pw, $db);
if ($conn->connect_error) die($conn->connect_error);

$user = mysql_entities_fix_string($conn, $_POST['user']);
$pass = mysql_entities_fix_string($conn, $_POST['pass']);
$query = "SELECT * FROM users WHERE user='$user' AND pass='$pass'";
//Etc...

function mysql_entities_fix_string($conn, $string)
{
  return htmlentities(mysql_fix_string($conn, $string));
}

function mysql_fix_string($conn, $string)
{
  if (get_magic_quotes_gpc()) $string = stripslashes($string);
  return $conn->real_escape_string($string);
}
```

## Escaping Strings with MySQLI

* `mysqli::real_escape_string` && `mysqli::escape_string` aa `mysqli_real_escape_string` : Escapes special characters in a string for use in an `SQL` statement, taking into account the current charset of the connection

* Object oriented style

  ```php
  $conn = new mysqli("localhost", "my_user", "my_password", "world");

  // check connection 
  if (mysqli_connect_errno()) {
      printf("Connect failed: %s\n", mysqli_connect_error());
      exit();
  }

  $city = "'s Hertogenbosch";

  // this query will fail, cause we did not escape $city
  if (!$conn->query("INSERT into myCity (Name) VALUES ('$city')")) {
      printf("Error: %s\n", $mysqli->sqlstate);
  }

  $city = $conn->real_escape_string($city);

  // this query with escaped $city will work
  if ($conn->query("INSERT into myCity (Name) VALUES ('$city')")) {
      printf("%d Row inserted.\n", $mysqli->affected_rows);
  }

  $conn->close();
  ```

* Procedural style
  
  ```php
  $link = mysqli_connect("localhost", "my_user", "my_password", "world");

  // check connection
  if (mysqli_connect_errno()) {
      printf("Connect failed: %s\n", mysqli_connect_error());
      exit();
  }

  $city = "'s Hertogenbosch";

  // this query will fail, cause we didn't escape $city
  if (!mysqli_query($link, "INSERT into myCity (Name) VALUES ('$city')")) {
      printf("Error: %s\n", mysqli_sqlstate($link));
  }

  $city = mysqli_real_escape_string($link, $city);

  // this query with escaped $city will work
  if (mysqli_query($link, "INSERT into myCity (Name) VALUES ('$city')")) {
      printf("%d Row inserted.\n", mysqli_affected_rows($link));
  }

  mysqli_close($link);
  ```

##  Using mysqli Procedurally:

* If you prefer, there is an alternative set of functions you can use to access `mysqli` in a procedural (rather than object-oriented) manner.

* Connect and Check Errors:
  
  ```php
  // So, instead of creating a $conn object like this:
  $conn = new mysqli($hn, $un, $pw, $db);

  // You can use the following:
  $link = mysqli_connect($hn, $un, $pw, $db);

  // To check that the connection has been made and handle it
  if (mysqli_connect_errno()) die(mysqli_connect_error());
  
  // And to close the connection to MySQL, enter this command:
  mysqli_close($link);
  ```

* Query and find out the number of data
  
  ```php
  $result = mysqli_query($link, "SELECT * FROM classics");
  $rows = mysqli_num_rows($result);
  // An integer is returned in $rows . 
  // You can fetch the actual data one row at a time in the following way, which returns a numeric array:
  $row = mysqli_fetch_array($result, MYSQLI_NUM);

  // In this instance, $row[0] will contain the first column of data, $row[1] the second, and so on.
  ```

* The insert `ID` of an insert operation
  
  ```php
  $insertID = mysqli_insert_id($result);
  ```

* Scaping strings procedurally with `mysqli`
  
  ```php
  $escaped = mysqli_real_escape_string($link, $val);
  ```

* Prepare a statement with `mysqli`

  ```php
  $stmt = mysqli_prepare($link, 'INSERT INTO classics VALUES(?,?,?,?,?)');

  // To bind variables to the prepared statement, you would then use the following:
  mysqli_stmt_bind_param($stmt, 'sssss', $author, $title, $category, $year, $isbn);

  // And to execute the prepared statement after assigning the variables with the required values, you would issue this call:
  mysqli_stmt_execute($stmt);

  // To close a statement, issue the following command:
  mysqli_stmt_close($stmt);

  // And to close the connection to MySQL, enter this command:
  mysqli_close($link);
  ```

* For complete details on using prepared statements (procedurally or otherwise), [check out](https://tinyurl.com/mysqlistmt). 
* And for more advice on all aspects of `mysqli`, [visit](https://tinyurl.com/usingmysqli).
