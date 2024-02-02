# <center>DATE FUNCTIONS</center>


* [Date and Times Functions](#functions)

## Types `DATE` `TIME` et `DATETIME`:

* Pour entrer une date, Il faut donner d'abord l'année (2 ou 4 chiffres), ensuite le mois (2 chiffres) et pour finir, le jour (2 chiffres), sous forme de nombre ou de chaîne de caractères. 

* MySQL supporte des DATE allant de '1001-01-01' à '9999-12-31'

* `DATE`: `YYYY-MM-DD`
  
  ```sql
  'AAAA-MM-JJ'         -- c'est sous ce format-ci qu'une DATE est stockée dans MySQL
  'AAMMJJ'
  'AAAA/MM/JJ'
  'AA+MM+JJ'
  'AAAA%MM%JJ'
  AAAAMMJJ             -- Nombre
  AAMMJJ               -- Nombre
  ```
  
* `DATETIME`: `YYY-MM-DD HH:MM:SS`
    
    ```sql
    'AAAA-MM-JJ HH:MM:SS'  -- C'est sous ce format-ci qu'un DATETIME est stocké dans MySQL
    'AA*MM*JJ HH+MM+SS'
    AAAAMMJJHHMMSS         -- Nombre
    ```

* `YEAR`: `YYYY` || `YY`
  * Si vous n'avez besoin de retenir que l'année, YEAR est un type intéressant car il ne prend qu'un seul octet en mémoire.
  * Cependant, un octet ne pouvant contenir que 256 valeurs différentes, YEAR est fortement limité : on ne peut y stocker que des années entre 1901 et 2155. Ceci dit, ça devrait suffire à la majorité d'entre vous pour au moins les cent prochaines années.
  * On peut entrer une donnée de type YEAR sous forme de chaîne de caractères ou d'entiers, avec 2 ou 4 chiffres. Si l'on ne précise que deuxchiffres, le siècle est ajouté par MySQL selon les mêmes critères que pour DATE et DATETIME, à une exception près: si l'on entre 00 (un entier donc), ilsera interprété comme la valeur par défaut de YEAR 0000. Par contre, si l'on entre '00' (une chaîne de caractères), elle sera bien interprétée comme l'année 2000.
  * Plus de précisions sur les valeurs par défaut des types temporels dans quelques instants !


* `TIMESTAMP`: `YYYY-MM-DD HH:MM:SS`

  Par définition, le timestamp d'une date est le nombre de secondes écoulées depuis le 1er janvier 1970, 0h0min0s (TUC) et la date en question.

  Les timestamps étant stockés sur 4 octets, il existe une limite supérieure : le 19 janvier 2038 à 3h14min7s. Par conséquent, vérifiez bien que vous êtes dans l'intervalle de validité avant d'utiliser un timestamp.

  Le type ``TIMESTAMP`` de MySQL est cependant un peu particulier. Prenons par exemple le 4 octobre 2011, à 21h05min51s.

  Entre cette date et le 1er janvier 1970, 0h0min0s, ils'est écoulé exactement 1317755151 secondes. Le nombre 1317755151 est donc, par définition, le timestamp de cette date du 4 octobre 2011, 21h05min51s.

  Pourtant, pour stocker cette date dans un ``TIMESTAMP`` ``SQL``, ce n'est pas 1317755151 qu'on utilisera, mais 20111004210551. C'està-dire l'équivalent, au format numérique, du ``DATETIME`` '2011-10-04 21:05:51'.

  Le ``TIMESTAMP`` SQL n'a donc de timestamp que le nom. Il ne sert pas à stocker un nombre de secondes, mais bien une date sous format numérique ``AAAAMMJJHHMMSS`` (alors qu'un ``DATETIME`` est donc stocké sous forme de chaîne de caractères).

  Il n'est donc pas possible de stocker un "vrai" timestamp dans une colonne de type ``TIMESTAMP``. C'est évidemment contreintuitif, et source d'erreur.

  Notez que malgré cela, le TIMESTAMP SQL a les même limites qu'un vrai timestamp : il n'acceptera que des date entre le 1e janvier 1970 à 00h00min00s et le 19 janvier 2038 à 3h14min7s.

* `TIME`: `HH:MM:SS`

    ```sql
    'HH:MM:SS'
    'HHH:MM:SS'
    'MM:SS'
    'J HH:MM:SS'
    'HHMMSS'
    HHMMSS             # Nombre
    ```
    
* MySQL supporte des TIME allant de '-838:59:59' à '838:59:59'

## Les champs de type date:

* Voici les différents types de dates que peut stocker MySQL :

  * `DATE` : stocke une date au format AAAA-MM-JJ (Année-Mois-Jour)
  * `TIME` : stocke un moment au format HH:MM:SS (Heures:Minutes:Secondes)
  * `DATETIME` : stocke la combinaison d'une date et d'un moment de la journée au format AAAA-MM-JJ HH:MM:SS.
  * `TIMESTAMP` : stocke le nombre de secondes passées depuis le 1er janvier 1970 à 00 h 00 min 00 s
  * `YEAR` : stocke une année, soit au format AA, soit au format AAAA.


***

<a name="functions"/>

## <center>DATES and TIMES Functions:</center>

### Table Of Content
* [DATE & TIMES Functions](#dateTimeFunctions)
* [Formats Standards](#formatStandards)
* [Day Functions](#dayFunctions)
* [MONTH Functions](#monthFunctions)
* [TIME Functions](#timeFunctions)
* [Calculating Intervals Between Dates or Times](#intervalsDates)

<a name="dateTimeFunctions"/>

## <center>DATES and TIMES Functions:</center>

### Extracting Parts of Dates or Times

* MySQL includes many functions for extracting date and time subpart extraction

  ```sql
  mysql> SELECT dt, DATE(dt), TIME(dt) FROM datetime_val;
  mysql> SELECT dt, YEAR(dt), DAYOFMONTH(dt), HOUR(dt), SECOND(dt) FROM datetime_val;
  mysql> SELECT dt, DAYOFYEAR(dt) FROM date_val;
  mysql> SELECT d, DAYNAME(d), LEFT(DAYNAME(d), 3) FROM date_val;
  ```

| Function | Return value
|----------|--------------------
| `YEAR()` | Year of date
| `MONTH()` | Month number (1..12)
| `MONTHNAME()` | Month name (January..December)
| `DAYOFMONTH()` | Day of month (1..31)
| `DAYNAME()` | Day name (Sunday..Saturday)
| `DAYOFWEEK()` | Day of week (1..7 for Sunday..Saturday)
| `WEEKDAY()` | Day of week (0..6 for Monday..Sunday)
| `DAYOFYEAR()` | Day of year (1..366)
| `HOUR()` | Hour of time (0..23)
| `MINUTE()` | Minute of time (0..59)
| `SECOND()` | Second of time (0..59)
| `EXTRACT()` | Varies


### Track Row Modification Times

* A `TIMESTAMP` or `DATETIME` column declared with the `DEFAULT CURRENT_TIMESTAMP` attribute initializes automatically for new rows. Simply omit the column from `INSERT` statements and MySQL sets it to the row-creation time.
* A `TIMESTAMP` or `DATETIME` column declared with the `ON UPDATE CURRENT_TIMESTAMP` attribute automatically updates to the current date and time when you change any other column in the row from its current value.

  ```sql
  CREATE TABLE tsdemo (
   val INT,
   ts_both TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   ts_create TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   ts_update TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
  ```
* The `TIMESTAMP` columns have these properties:
  * `ts_both` auto-initializes and auto-updates. This is useful for tracking the time of any change to a row, for both inserts and updates.
  * `ts_create` auto-initializes only. This is useful when you want a column to be set to the time at which a row is created, but remain constant thereafter.
  * `ts_update` auto-updates only. It is set to the column default (or value you specify explicitly) at row-creation time and it auto-updates for changes to the row there after. The use cases for this are more limited—for example, to track row creation and last-modification times separately (using ts_update in conjunction with ts_create), rather than together in a single column like ts_both.
  
  ```sql
  mysql> INSERT INTO tsdemo (val) VALUES(5);
  mysql> INSERT INTO tsdemo (val,ts_both,ts_create,ts_update) VALUES(10,NULL,NULL,NULL);
  mysql> SELECT * FROM tsdemo;
  ```
  
### `STR_TO_DATE()`

* One way to rewrite non-ISO values for date entry is to use the `STR_TO_DATE()` function, which takes a string representing a temporal value and a format string that specifies the 'syntax' of the value.

  ```sql
  mysql> SELECT STR_TO_DATE('May 13, 2007', '%M %d, %Y');
      -> 2015-05-13
  ```

### `DATE_FORMAT`

* Formatting functions are advantageous when you want to extract more than one part of a value, or display extracted values in a format different from the default.
* Takes two arguments: a 
  * `DATE`, `DATETIME`, or `TIMESTAMP` value
  * String describing how to display the value.

  ```sql
  mysql> SET @date_time = '2018-11-26 07:42:00';
  mysql> SELECT DATE_FORMAT(@date_time,'%M %d, %Y');
      -> November 26, 2018
  
  mysql> SELECT DATE_FORMAT(@date_time,'%c/%e/%y %r');
      ->  11/26/18 07:42:00 AM
      
  mysql> SELECT DATE_FORMAT(@date_time,'%M %e, %Y %T');
      -> November 26, 2018 07:42:00
  ```

| Spécificateur | Description |
| :------------:|-------------------------------------------------------|
| %d | Jour du mois (nombre à deuxchiffres, de 00 à 31) |
| %e | Jour du mois (nombre à un ou deuxchiffres, de 0 à 31) |
| %D | Jour du mois, avec suffixe (1rst, 2nd,…, 31th) en anglais |
| %w | Numéro du jour de la semaine (dimanche = 0,…, samedi = 6) |
| %W | Nomdu jour de la semaine |
| %a | Nomdu jour de la semaine en abrégé |
| %m | Mois (nombre de deuxchiffres, de 00 à 12) |
| %c | Mois (nombre de un ou deuxchiffres, de 0 à 12) |
| %M | Nomdu mois |
| %b | Nomdu mois en abrégé |
| %y | Année, sur deuxchiffres |
| %Y | Année, sur quatre chiffres |
| %r | Heure complète, format 12h (hh:mm:ss AM/PM) |
| %T | Heure complète, format 24h (hh:mm:ss) |
| %h | Heure sur deuxchiffres et sur 12 heures (de 00 à 12) |
| %H | Heure sur deuxchiffres et sur 24 heures (de 00 à 23) |
| %l | Heure sur un ou deuxchiffres et sur 12 heures (de 0 à 12) |
| %k | Heure sur un ou deuxchiffres et sur 24 heures (de 0 à 23) |
| %i | Minutes (de 00 à 59) |
| %s | ou %S Secondes (de 00 à 59) |
| %p | AM/PM |


### `TIME_FORMAT()` 

* Similar to `DATE_FORMAT()`. It works with `TIME`, `DATETIME`, or `TIMESTAMP` values, but understands only time-related specifiers in the format string

  ```sql
  mysql> SELECT TIME_FORMAT(@date_time, '%r') AS '12-hour time';
      -> 07:42:00 AM
  mysql> SELECT TIME_FORMAT(@date_time, '%T') AS '24-hour time';
      -> 07:42:00
  mysql> SELECT TIME_FORMAT(@date_time, '%H:%i') AS 'hours/minutes';
      -> 07:42
  ```

* If `DATE_FORMAT()` or `TIME_FORMAT()` cannot produce the results that you want, write a stored function that does. 
* Suppose that you want to convert 24-hour TIME values to 12-hour format but with a suffix of a.m. or p.m.

  ```sql
  mysql> CREATE FUNCTION time_ampm (t TIME)
      -> RETURNS VARCHAR(13)         -- mm:dd:ss {a.m.|p.m.} format
      -> DETERMINISTIC
      -> RETURN CONCAT(LEFT(TIME_FORMAT(t, '%r'), 9),
      -> IF(TIME_TO_SEC(t) < 12*60*60, 'a.m.', 'p.m.'));
  
  mysql> SELECT t1 time_ampm(t1) FROM time_val;
  
  mysql> SELECT t1, TIME_FORMAT(t1,'%H:%i:00') FROM time_val; -- Produces time values that have the seconds part set to 00
  ```
  
### `NOW()` && `SYSDATE()` 

* Obtenir la date et l'heure actuelles
  
  ```sql
  INSERT INTO minichat(pseudo, message, date) VALUES('Mateo', 'Message !', NOW())
  INSERT INTO minichat(pseudo, message, date) VALUES('Mateo', 'Message !', SYSDATE())
  ```

### `CURDATE()`

* Qui retournent respectivement uniquement la date (AAAA-MM-JJ)
  
  ```sql
  INSERT INTO minichat(pseudo, message, date) VALUES('Mateo', 'Message !', CURDATE())
  ```

* `CURRENT_TIMESTAMP` ou `CURRENT_TIMESTAMP()`
* `LOCALTIME` ou `LOCALTIME()`
* `LOCALTIMESTAMP` ou `LOCALTIMESTAMP()`
  
  ```sql
  mysql-> SELECT LOCALTIME, LOCALTIMESTAPM(), CURRENT_TIMESTAPM();
       -> '2018-08-12 07:25:00'
  ```

## `DATEDIFF(expr1, expr2)`

* Returns expr1 − expr2 expressed as a value in days from one date to the other. expr1 and expr2 are date or date-and-time expressions. Only the date parts of the values are used in the calculation.
  
  ```sql
  mysql> SELECT DATEDIFF('2007-12-31 23:59:59','2007-12-30');
      -> 1
  mysql> SELECT DATEDIFF('2010-11-30 23:59:59','2010-12-31');
      -> -31
  mysql> SELECT DATEDIFF(CURDATE(), '1986-11-18');
      -> -11588
  ```
  
## `DATE_ADD` et `DATE_SUB`

* Ajouter ou soustraire des dates

  * Il est possible d'ajouter ou de soustraire des heures, minutes, secondes, jours, mois ou années à une date. Il faut envoyer deux paramètres à la fonction : la date sur laquelle travailler et le nombre à ajouter ainsi que son type.

  ```sql
  -- Le champdate_expirationcorrespond à « la date de l'entrée + 15 jours ».
  SELECT pseudo, message, DATE_ADD(date, INTERVAL 15 DAY) AS date_expiration FROM minichat

  -- Indiquer que les messages expirent dans deux mois :
  SELECT pseudo, message, DATE_ADD(date, INTERVAL 2 MONTH) AS date_expiration FROM minichat
  ```

## `EXTRACT()` 

* Is another function for obtaining individual parts of temporal values
* The keyword indicating what to extract from the value should be a unit specifier such as `YEAR`, `MONTH`, `DAY`, `HOUR`, `MINUTE`, or `SECOND`. Unit specifiers are singular, not plural.
    
    ```sql
    mysql> SELECT EXTRACT(DAY FROM '2018-11-24'), EXTRACT(HOUR FROM '15:43:22');
        -> 24 | 15
    ```
  
* Usefull Example
  
  ```sql
  mysql> SELECT CURDATE(), YEAR(CURDATE()) AS Year,
      -> MONTH(CURDATE()) AS Month, MONTHNAME(CURDATE()) AS Monthname,
      -> DAYOFMONTH(CURDATE()) AS Day, DAYNAME(CURDATE()) AS Dayname;

  -- With Time
  mysql> SELECT NOW(), HOUR(NOW()) AS hour,
      -> MINUTE(NOW()) AS minute, SECOND(NOW()) AS second;
      ```

<a name="formatStandards"/>

## <center>Formats standards</center>

* Il existe un certain nombre de formats de date et d'heure standards, prédéfinis, que l'on peut utiliser dans la fonction `DATE_FORMAT()`. Pour obtenir ces formats, il faut appeler la fonction `GET_FORMAT(type, standard)`.
* Il existe cinq formats standards :
  * 'EUR'
  * 'USA'
  * 'ISO'
  * 'JIS'
  * 'INTERNAL'

| Fonction | Format | Exemple |
| ---------| -------|---------|
| `GET_FORMAT(DATE,'USA')`      | '%m.%d.%Y' | 10.30.1988 |
| `GET_FORMAT(DATE,'JIS')`      | '%Y-%m-%d' | 1988-10-30 |
| `GET_FORMAT(DATE,'ISO')`      | '%Y-%m-%d' | 1988-10-30 |
| `GET_FORMAT(DATE,'EUR')`      | '%d.%m.%Y' | 30.10.1988 |
| `GET_FORMAT(DATE,'INTERNAL')` | '%Y%m%d' | 19881031 |
| `GET_FORMAT(DATETIME,'USA')`  | '%Y-%m-%d %H.%i.%s' | 1988-10-30 13.44.33 |
| `GET_FORMAT(DATETIME,'JIS')`  | '%Y-%m-%d %H:%i:%s' | 1988-10-30 13:44:33 |
| `GET_FORMAT(DATETIME,'ISO')`  | '%Y-%m-%d %H:%i:%s' | 1988-10-30 13:44:33 |
| `GET_FORMAT(DATETIME,'EUR')`  | '%Y-%m-%d %H.%i.%s' | 1988-10-30 13.44.33 |
| `GET_FORMAT(DATETIME,'INTERNAL')` | '%Y%m%d%H%i%s' | 19881030134433 |
| `GET_FORMAT(TIME,'USA')`      | '%h:%i:%s %p' | 1:44:33 PM |
| `GET_FORMAT(TIME,'JIS')`      | '%H:%i:%s' | 13:44:33 |
| `GET_FORMAT(TIME,'ISO')`      | '%H:%i:%s' | 13:44:33 |
| `GET_FORMAT(TIME,'EUR')`      | '%H.%i.%S' | 13.44.33 |
| `GET_FORMAT(TIME,'INTERNAL')` | '%H%i%s' | 134433 |


### `CONVERT_TZ()` 

* Converts temporal values between time zones. It takes three arguments: 
  * date-and-time value and two time zone indicators. 
* The function interprets the date-and-time value as a value in the first time zone and returns the value shifted
into the second time zone.

  ```sql
  mysql> SET @dt = '2014-11-23 09:00:00';
  mysql> SELECT @dt AS Chicago,
      -> CONVERT_TZ(@dt,'US/Central','Europe/Berlin') AS Berlin,
      -> CONVERT_TZ(@dt,'US/Central','Europe/London') AS London,
      -> CONVERT_TZ(@dt,'US/Central','America/Edmonton') AS Edmonton,
      -> CONVERT_TZ(@dt,'US/Central','Australia/Brisbane') AS Brisbane\G
  ```

* The corresponding statement with numeric time zones looks like this:
  
  ```sql
  mysql> SELECT @dt AS Chicago,
      -> CONVERT_TZ(@dt,'-06:00','+01:00') AS Berlin,
      -> CONVERT_TZ(@dt,'-06:00','+00:00') AS London,
      -> CONVERT_TZ(@dt,'-06:00','-07:00') AS Edmonton,
      -> CONVERT_TZ(@dt,'-06:00','+10:00') AS Brisbane\G
  ```

***

<a name="dayFunctions"/>

## <center>DAY Functions</center>

### `DAYNAME(date)`: 

* Returns the name of the weekday for date. The language used for the name is controlled by the value of the lc_time_names system variable
  
  ```sql
  mysql> SELECT DAYNAME('2007-02-03');
      -> 'Saturday'
      
  mysql> SELECT d, DAYNAME(d), LEFT(DAYNAME(d),3) FROM date_val;
      ->  2017-03-16 | Thursday | Thu 
  ```

### `DAYOFWEEK(date)`: 

* Returns the weekday index for date (1 = Sunday, 2 = Monday, …, 7 = Saturday).
  
  ```sql
  mysql> SELECT DAYOFWEEK('2007-02-03');
      -> 7
  ```
  
### `WEEKDAY(date)`

* Returns values from 0 to 6, corresponding to ( 0 = Monday through 6 = Sunday)
 
 ```sql
  mysql> SELECT WEEKDAY('2007-02-03');
      -> 5
  ```

### `DAYOFOFMONTH(date)`: 

* Returns the day of the month for date, in the range 1 to 31
  
  ```sql
  mysql> SELECT DAYOFMONTH('2007-02-03');
      -> 3
  ```

### `DAYOFYEAR(date)`: 
* Returns the day of the year for date, in the range 1 to 366.
  
  ```sql
  mysql> SELECT DAYOFYEAR('2007-02-03');
      -> 34
  ```

<a name="monthFunctions"/>

## <center>MONTH Functions</center>

### `MONTH(date)`

* Returns the month for date, in the range 1 to 12 for January to December
  
  ```sql
  mysql> SELECT MONTH('2008-02-03');
      -> 2
  ```

### `MONTHNAME(date)`

* Returns the full name of the month for date. The language used for the name is controlled by the value of the lc_time_names system variable
  
  ```sql
  mysql> SELECT MONTHNAME('2008-02-03');
      -> 'February'
  ```

***

<a name="timeFunctions"/>

## <center>TIME Functions</center>

### `CURTIME()`

* Retournent respectivement uniquement l'heure (HH:MM:SS).
  
  ```sql
  INSERT INTO minichat(pseudo, message, date, time) VALUES('Mateo', 'Message !', CURTIME())
  ```
  
### `HOUR()`,`MINUTE()`,`SECOND()`

* Extraire les heures, minutes, secondes
  
  ```sql
  SELECT pseudo, message, HOUR(date) AS heure FROM minichat
  
  SELECT pseudo, message, MINUTE(date) AS Minute FROM minichat
  
  SELECT pseudo, message, SECOND(date) AS Seconde FROM minichat
  ```  

### `MAKETIME(hour,minute,seconds)`

* takes component hour, minute, and second values as arguments and combines them to produce a time
  
  ```sql
  mysql> SELECT MIKETIME(15,30,25);
      -> 15:30:25
  ```

### Converting between times and seconds

* To convert from one to the other, use the `TIME_TO_SEC()` and `SEC_TO_TIME()` functions.

```sql
mysql> SET @time = '12:00:00';
mysql> SELECT TIME_TO_SEC(@time), SEC_TO_TIME(TIME_TO_SEC(@time));
    -> 43200 | 12:00:00

-- Express time values as minutes, hours, or days.
mysql> SELECT @time, TIME_TO_SEC(@time) AS 'Seconds', 
    -> TIME_TO_SEC(@time) / 60 AS 'Minutes',
    -> TIME_TO_SEC(@time) / (60 * 60) AS 'Hours',
    -> TIME_TO_SEC(@time) / (24 *60 *60) AS 'Days';

    -> 12:00:00 |   43200 | 720.0000 | 12.0000 | 0.5000
```

<a name="intervalsDates"/>

## <center>Calculating Intervals Between Dates or Times</center>

* To calculate an interval in days between two date values, use the DATEDIFF() function

  ```sql
  mysql> SELECT DATEDIFF('2018-11-18', '1986-11-18');
      -> 11688
  mysql> SELECT FLOOR(DATEDIFF('2018-11-18', '1986-11-18') / 360);
      -> 32
  ```

* To calculate an interval between TIME values as another TIME value, use the `TIMEDIFF()` function:
  
  ```sql
  mysql> SELECT TIMEDIFF('18:00:00', '16:30:00');
      -> 01:30:00
  
  mysql> SELECT @time1, @time2,
      -> IF(TIMEDIFF(@time2,@time1) >= 0, '+', '-') AS sign,
      -> HOUR(TIMEDIFF(@time2,@time1)) AS hour,
      -> MINUTE(TIMEDIFF(@time2,@time1)) AS minute,
      -> SECOND(TIMEDIFF(@time2,@time1)) AS second ;
  ```
 
* `TIMESTAMPDIFF()` function provides another way to calculate intervals. It enables you to specify the units in which intervals should be expressed: `TIMESTAMPDIFF(unit,val1,val2)`
 
  ```sql
  mysql> SET @d1 = '2000-01-01 00:00:00', @d2 = '2018-01-01 00:00:00';
  mysql> SELECT TIMESTAMPDIFF(MINUTE,@dt1,@dt2) AS minutes;
      -> 9468000 
  mysql> SELECT TIMESTAMPDIFF(HOUR,@dt1,@dt2) AS hours;
      -> 157800
  mysql> SELECT TIMESTAMPDIFF(DAY,@dt1,@dt2) AS days;
      -> 6575
  mysql> SELECT TIMESTAMPDIFF(WEEK,@dt1,@dt2) AS weeks;
      -> 939
  mysql> SELECT TIMESTAMPDIFF(YEAR,@dt1,@dt2) AS years;
      -> 18
  ```

### Adding Date or Time Values

* To add a time to a time or date-and-time value, use the `ADDTIME()` function:

  ```sql
  mysql> SET @d1 = '15:30:00', @d2 = '14:00:00';
      -> 29:30:00
  mysql> SET @d1 = '2018-03-01 12:00:00', @d2 = '14:00:00';
      -> 2018-03-02 02:00:00
  ```

* To add a time to a date or date-and-time value, use the TIMESTAMP() function:

  ```sql
  mysql> SET @d = '1984-03-01', @t = '15:30:00';
  mysql> SELECT TIMESTAMP(@d,@t);
      -> 1984-03-01 15:30:00
  ```

* MySQL also provides `DATE_ADD()` and `DATE_SUB()` functions for adding intervals to dates and subtracting intervals from dates. Each function takes a date (or date-and-time) value d and an interval, expressed using the following syntax:

```sql
mysql> SELECT CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY);
    -> 2018-11-26 | 2018-11-29
mysql> SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 1 WEEK);
    -> 2018-11-26 | 2018-11-19
mysql> SELECT NOW(), DATE_ADD(NOW(), INTERVAL 24 HOUR);
    ->  2018-11-26 09:00:40 | 2018-11-27 09:00:40
mysql> SELECT NOW(), DATE_ADD(NOW(), INTERVAL '14:30' HOUR_MINUTE);
    -> 2018-11-26 09:02:13 | 2018-11-26 23:32:13
mysql> SELECT NOW(), DATE_ADD(NOW(), INTERVAL '3 4' DAY_HOUR);
    -> 2018-11-26 09:04:02 | 2018-11-29 13:04:02
```

* `DATE_ADD()` and `DATE_SUB()` are interchangeable because one is the same as the other with the sign of the interval value flipped. 
  * These two expressions are equivalent for any date value:
  
  ```sql
  mysql> SELECT CURDATE(), DATE_ADD(CURDATE(), INTERVAL -3 MONTH);
      -> 2018-11-26 | 2018-08-26
  mysql> SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 3 MONTH);
      -> 2018-11-26 | 2018-08-26
  ```

* You can also use the `+ INTERVAL` or `- INTERVAL` operator to perform date interval addition or subtraction:

  ```sql
  mysql> SELECT CURDATE(), CURDATE() + INTERVAL 1 YEAR;
      -> 2018-11-26 | 2019-11-26
  mysql> SELECT CURDATE(), CURDATE() - INTERVAL 1 YEAR;
      -> 2018-11-26 | 2017-11-26
  mysql> SELECT NOW(), NOW() - INTERVAL '1 3' DAY_HOUR;
      > 2018-11-26 09:15:02 | 2018-11-25 06:15:02
  ```

###  Calculating Ages

* To calculate ages, use the `TIMESTAMPDIFF()` function. Pass it a birth date, a current date, and the unit in which you want the age expressed: `TIMESTAMPDIFF(unit,birth,current)`

  ```sql
  mysql> SELECT TIMESTAMPDIFF(YEAR, '1986-11-18', CURDATE());
      -> 32
  mysql> SELECT TIMESTAMPDIFF(MONTH, '1986-11-18', CURDATE());
      -> 384
  mysql> SELECT CONCAT(TIMESTAMPDIFF(DAY, '1986-11-18', CURDATE()), ' Days');
      -> 11696 Days

  mysql> SELECT TIMESTAMPDIFF(YEAR, '1962-06-12', '1986-11-18');
      -> 24
  ```

### Finding the First Day, Last Day, or Length of a Month

* To find the first day of the month for a given date, shift the date back by one fewer days than its `DAYOFMONTH()` value

  ```sql
  mysql> SET @date = '2018-11-26';
  mysql> SELECT @date, DATE_SUB(@date, INTERVAL DAYOFMONTH(@date)-1 DAY);
      -> 2018-11-26 | 2018-11-01
  mysql> SELECT @date, DAYNAME(DATE_SUB(@date, INTERVAL DAYOFMONTH(@date)-1 DAY));
      -> Thursday

  mysql> SELECT DATE_ADD(DATE_SUB(@date, INTERVAL DAYOFMONTH(@date)-1 DAY), INTERVAL -1 MONTH) AS '1st Of Previus Month';
      -> 2018-10-01
  mysql> SELECT DATE_ADD(DATE_SUB(@date, INTERVAL DAYOFMONTH(@date)-1 DAY), INTERVAL 1 MONTH) AS '1st Of Next Month';
      -> 2018-12-01
  ```

* It’s easier to find the last day of the month for a given date because there is a function for it:

  ```sql
  mysql> SELECT @d, LAST_DAY(@d) AS 'Last of month';
      -> 2018-11-26 | 2018-11-30
  mysql> SELECT LAST_DAY(DATE_ADD(@d, INTERVAL -1 MONTH)) AS 'Last of previus month';
      -> 2018-10-31
  mysql> SELECT @d, LAST_DAY(DATE_ADD(@d, INTERVAL 1 MONTH)) AS 'Last of next month';
      -> 2018-12-31
      
  -- With DATE-FORMAT
  mysql> SELECT DATE_FORMAT(@d,'%Y-%m-01') AS '1st of month A',
  ```

* To find the length of a month in days, determine the date of its last day with `LAST_DAY()`, then use `DAYOFMONTH()`.

  ```sql
  mysql> SELECT @d, DAYOFMONTH(LAST_DAY(@d));
      -> 30
  ```

### Leap-Year

```sql
mysql> SET @d = '2018-11-26';
mysql> SELECT (YEAR(@d) % 4 = 0) AND ((YEAR(@d) % 100 <> 0) OR (YEAR(@d) % 400 = 0));
    -> 0
mysql> SET @d = '2020-11-26';
mysql> SELECT (YEAR(@d) % 4 = 0) AND ((YEAR(@d) % 100 <> 0) OR (YEAR(@d) % 400 = 0));
    -> 1
```

### Selecting Rows Based on Temporal Characteristics

```sql
mysql> SELECT d FROM date_val where d < '1900-01-01';
mysql> SELECT d FROM date_val where d BETWEEN '1900-01-01' AND '1999-12-31';

mysql> SELECT * FROM history WHERE d = DATE_SUB(CURDATE(),INTERVAL 5 YEAR); -- Find events occurring exactly 5 years ago

-- Find dates that occur later than 20 years ago
mysql> SELECT d FROM date_val WHERE d >= DATE_SUB(CURDATE(),INTERVAL 20 YEAR);
```

* Who has a birthday today?
  
  ```sql
  mysql> SELECT d FROM date_val WHERE MONTH(d) = MONTH(CURDATE()) AND DAYOFMONTH(d) = DAYOFMONTH(CURDATE());
  ```

* Who has a birthday next month?

  ```sql
  mysql> SELECT d FROM date_val WHERE MONTH(d) = MONTH(DATE_ADD(CURDATE(), INTERVAL 1 MONTH));
  ```


* [All DATE TIME Functions](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)
