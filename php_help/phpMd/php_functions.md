### Table of content

* [Date and Time functions](#dateTime)
* [String functions](#string)

<a name="dateTime">

## Date and Time functions

```php
echo time();

date($format, $timestamp)
```

### The major date functions specifiers

* **_Day_** specifiers

| Format | Description | Returned value
|--------|-------------|-----------------------------
| d | Day of month, two digits, with leading zeros | 01 to 31
| j | day of the month, no leading zeros | 1 to 31
| D | Day of week, three letters | Mon to Sun
| l | Day of week, full names | Sunday to Saturday
| N | Day of week, numeric, Monday to Sunday | 1 to 7
| S | Suffix for day of month (useful with spedifier j) | st, nd, rd, or th
| w | Day of week, numeric, sunday to saturday | 0 to 6
| z | Day of year | 0 to 365

* **_Week_** specifier 

| Format | Description | Returned value
|--------|-------------|-----------------------------
| W | Week number of year | 01 to 52

* **_Month_** specifiers

| Format | Description | Returned value
|--------|-------------|-----------------------------
| F | Month name | January to December
| m | Month number with leading zeros | 01 to 12
| n | Month number, no leading zeros | 1 to 12
| M | Month name, three letters | Jan to Dec
| t | Number of days in given month | 28 to 31

* **_Year_** specifiers

| Format | Description | Returned value
|--------|-------------|-----------------------------
| L | Leap year | 1 = Yes, 0 = No
| y | Year, 2 digits | 00 to 99
| Y | Year, 4 digits | 0000 to 9999


* **_Time_** specifiers

| Format | Description | Returned value
|--------|-------------|-----------------------------
| a | Before or after midday, lowercase | am or pm
| A | Before of after midday, uppercase | AM or PM
| g | Hour of day, 12-hour format, no leading zeros | 1 to 12
| G | Hour of day, 24-hour format, no leading zeros | 00 to 24
| h | Hour of day, 12-hour format, with leading zeros | 01 to 12
| H | Hour of day, 24-hour format, with leading zeros | 00 to 24
| i | Minutes, with leading zeros | 00 to 59
| s | Seconds, with leading zeros | 00 to 59

* The complete list can be found at [This link](http://php.net/manual/en/class.datetime.php)

* `DATE_ATOM`: this is the format for atom feeds. The PHP format is "Y-m-d\TH:i:sP" and output is "2018-08-16T12:00:00+00:00".
* `DATE_COOKIE`: this is the format for cookies set from a web server or JS. The php format is "l, d-M-y H:i:s" and output is "Thursday, 16-Aug-18 12:00:00 UTC"
* `DATE_RSS`: This is the format of RSS feeds. The PHP format is "D, d M Y H:i:s O" and output "Thu, 16 Aug 2018 12:00:00 UTC"
* `DATE_W3C`: This is the format of World Wide Web consortium. The PHP format is "Y-m-d\TH:i:sP" and output "2018-08-16T12:00:00+00:00"
* The complete list can be found at [This link](http://php.net/manual/en/class.datetime.php)

***
<a name="string">

## String functions

* **_Explode(separator, string, limit)_**: Split string into array
  
  ```php
  $str = 'Hello From PHP';
  print_r(explode(' ', $str))  // Array { [0] => Hello, [1] => From, [2] => PHP }
  print_r(explode(' ', $str, 1))  // Array { [0] => Hello From PHP }
  print_r(explode(' ', $str, 2))  // Array { [0] => Hello, [1] => From PHP }
  
  print_r(explode(' ', $str, -1))  // Array { [0] => Hello, [1] => From }
  ```

* **_Implode(separator, string)_**: Split array into string, **_Join_** is an alias for **_implode_**.

  ```php
  $arr = array('Ahmed', 'Ibrahim', 'Hallala', 'Meziane');
  echo implode($arr);  // AhmedIbrahimHallalaMeziane
  echo implode(' & ', $arr);  // Ahmed & Ibrahim & Hallala & Meziane
  ```

* **str_split(string, length)**: split string into array

  ```php
  $str = 'Hello I Love PHP';
  print_r(str_split($str));        // Array { [0] => H, [1] => e, [2] => l ....}
  print_r(str_split($str, 2));     // Array { [0] => He, [1] => ll, [2] => o ....}
  ```
  
* **str_replace(search, replace, string, count)**

  ```php
  $str = 'Im learning PHP, Because PHP is good and easy to learn';
  $str2 = str_replace('PHP', 'JS', $str, $i);
  echo $str2 . ', And replacement count: ' . $i;
  // OUT: Im learning JS, Because JS is good and easy to learn, And replacement count: 2
  ```
