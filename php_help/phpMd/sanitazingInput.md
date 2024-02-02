Sanitizing Input
================

```php
<?php

function sanitizeString($var){
  $var = stripslashes($var);        // Get rid of inwanted slashes
  $var = strip_tags($var);          // Strip HTML entirely from an input, but ensure you use it before calling htmlentities
  $var = htmlentities($var);        // To remove any HTML from a string
  return $var;
}

function sanitizeMySQL($connection, $var){
  $var = $connection->real_escape_string($var);
  $var = sanitizeString($var);
  return $var;
}
?>
```

* Add this code to the end of your PHP programs, and you can then call it for each user input to sanitize, like this:

  ```php
  $var = sanitizeString($_POST['user_input']);
  ```
* Or, when you have an open MySQL connection, and a mysqli connection object(in this case, called $connection):

  ```php
  $var = sanitizeMySQL($conneciont, $_POST['user_input']);
  ```

* Remember that the safest way to secure MySQL from hacking attempts is to use placeholders and prepared statements

## Example:

```php
 $f = $c = '';
 if (isset($_POST['f'])) $f = sanitizeString($_POST['f']);
 if (isset($_POST['c'])) $c = sanitizeString($_POST['c']);
 if ($f != '') {
   $c = intval((5 / 9) * ($f - 32));
   $out = "$f °f equals $c °c";
 } elseif($c != '') {
   $f = intval((9 / 5) * $c + 32);
   $out = "$c °c equals $f °f";
 } else $out = "";
 
 function sanitizeString($var) {
   $var = stripslashes($var);
   $var = strip_tags($var);
   $var = htmlentities($var);
   return $var;
 }

```

