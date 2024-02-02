## Types Numerique:

| Type		  | Nombre d'octets | Minimum		                  | Maximum
|-----------|:---------------:|:----------------------------|:--------------------------
| TINYINT	  |	1	              | (4): -128	                  | (4): 127
| SMALINT	  | 2	              | (6): -32768	                | (6): 32767
| MEDIUMINT	|	3	              | (9): -8388608               | (9): 8388607
| INT		    |	4	              | (11): -214783648	          | (11): 2147483647
| BIGINT	  |	8	              | (20): -9223372036845775808  | (20): 9223372036845775807

* `SERIAL`  : `BIGINT UNSIGNED AUTO_INCREMENT NOT NULL`
* `BOOLEAN` : TRUE | FALSE.
* `UNSIGNED`: On ne precise pas s'il s'agit d'une valeur positive ou negative.
* `NUMERIC` : `DICIMAL`: acceptent 2 paramètre 
* `DICIMAL(5, 3)` : Pour stocker 5 chiffre, dont 3 sont aprés la virgule,(utiliser pour money)

### FLOAT, DOUBLE et REAL:
 
* `FLOAT`: s'utiliser sans paramètre, auquel cas quatre octets sont utilisés pour stocker les valeurs de la colonne. 
* Il est cependant possible de spécifier une précision et une échelle, de la même manière que pour `DECIMAL` et `NUMERIC`.

* `REAL` et `DOUBLE`: ils ne supportent pas de paramètres. 
* `DOUBLE` est normalement plus précis que `REAL` (stockage dans 8 octets contre stockage dans 4 octets), mais ce n'est pas le cas avec MySQL qui utilise 8 octets dans les deux cas. Je vous conseille donc d'utiliser DOUBLE pour éviter les surprises en cas de changement de SGBDR.

### Valeurs exactes vs. valeurs approchées

* Les nombres stockés en tant que `NUMERIC` ou `DECIMAL` sont stockés sous forme de chaînes de caractères. 
* Par conséquent, c'est la valeur exacte qui est stockée. 
* Les types `FLOAT`, `DOUBLE` et `REAL` sont stockés sous forme de nombres, et c'est une valeur approchée qui est stockée.
* Cela signifie que si vous stockez par exemple 56,6789 dans une colonne de type `FLOAT`, en réalité, 
  MySQL stockera une valeur qui se rapproche de 56,6789 (par exemple, 56,678900000000000001). 
* Cela peut poser problème pour des comparaison notamment (56,678900000000000001 n'étant pas égal à 56,6789). 
* S'il est nécessaire de conserver la précision exacte de vos données (ex: données bancaires), 
  il est donc conseillé d'utiliser un type numérique à valeur exacte (`NUMERIC` | `DECIMAL`).

- PGSQL

  | Data type         | Storage Size | Storage type   | Range
  |-------------------|--------------|----------------|---------------------------------------------------------
  | numeric, decimal  | variable     | Fixed-point    | Up to 131072 digits before the decimal; up to 16383 digits after the decimal
  | real              | 4 bytes      | Floating-point | 6 decimal digits precision
  | double precision  | 8 bytes      | Floating-point | 15 decimal digits precision

> There is a type call `money` in pgsql.

***

## Types Alphanumérique:

* MySQL provides several binary and nonbinary string data types.
* The maximum length is in bytes, whether the type is binary or nonbinary.
* For nonbinary types, the maximum number of characters is less for strings that contain multibyte characters:

| Binary data type | Nonbinary data type | Maximum length
|------------------|---------------------|--------------------
| BINARY           | CHAR                | 255
| VARBINARY        | VARCHAR             | 65,535
| TINYBLOB         | TINYTEXT            | 255
| BLOB             | TEXT                | 65,535
| MEDIUMBLOB       | MEDIUMTEXT          | 16,777,215
| LONGBLOB         | LONGTEXT            | 4,294,967,295


* `CHAR`, `BINARY`: Stores columns values using a fixed width, Shorter values are padded to the required length.
* `VARCHAR`, `VARBINARY`, and the `BLOB`, and `TEXT` types: Store values using only as much storage as required, up to the maximum column.

- Different character sets and collations.
  - If you specify `CHARACTER SET` and omit `COLLATE`, the default collation for the char-acter set is used.
  - If you specify `COLLATE` and omit `CHARACTER` SET, the character set implied by the collation name (the first part of the name) is used. 
  - If you omit both `CHARACTER SET` and `COLLATE`, the column is assigned the table default character set and collation. 
  
    ```sql
    mysql> CREATE TABLE mytbl (
        ->     utf8_str VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_danish_ci,
        ->     sjis_str VARCHAR(100) CHARACTER SET sjis COLLATE sjis_japanese_ci
        -> )
    ```

### `SET` et `ENUM`

* `ENUM`: Une colonne de type ENUM est une colonne pour laquelle on définit un certain nombre de valeurs autorisées.
* Un `ENUM` peut avoir maximum 65535 valeurs possibles
  
  ```sql
  type ENUM('admin', 'other');
  
  -- On pourra stocker dans cette colonne :
  '' ;                    -- Chaîne vide
  'admin' ;
  'other' ;
  ```
  
* `SET`: Une colonne SET est en effet une colonne qui permet de stocker une chaîne de caractères dont les valeurs possibles sont prédéfinies par l'utilisateur. 

* La différence avec `ENUM`, c'est qu'on peut stocker dans la colonne entre 0 et x valeur(s), x étant le nombre de valeurs autorisées.
  
  ```sql
  espece SET('chat', 'chien', 'tortue');
  
  # On pourra stocker dans cette colonne :
  '';                         # Chaîne vide
  'chat' ;
  'chat,tortue' ;
  'chat,chien,tortue' ;
  'chien,tortue' ;
  ...
  ```
  
* On ne peut pas stocker la même valeur plusieurs fois dans un `SET`. "chien,chien" par exemple, n'est donc pas valable
* Un champ de type `SET` peut avoir au plus 64 valeurs définies

### Setting the client Connection Character Set

* Configure your connection to use the appropriate character set.
* Issue a `SET NAMES` statement after you connect:

  ```sql
  mysql> SET NAMES 'utf8';
  mysql> SET NAMES 'utf8' COLLATE 'utf8_general_ci';
  ```
* You can use `--default-character-set=utf8` to specify the character set at program invocation. or put the option in an option file 

  ```bash
  [mysql]
  default-character-set=utf8
  ```

* For `PDO`, and `Python/Connector` use `charset` option in your data souce name

  ```php
  $dsn = 'mysql:host=localhost;dbnam=cookbook;charset=utf8';
  conn_params = {'database': 'databasename', 'host': 'host', 'user': 'user', 'password': 'passwd', 'charset': 'utf8'}
  ```

***

### Character Set.

* To see which character sets are available for nonbinary strings

  ```sql
  SHOW CHARACTER SET;
  ```
- To determine whether a given string contains multibyte characters, use the **_LENGTH()_** and **_CHAR_LENGTH_** functions.
- If **_LENGTH()_** is greater than **_CHAR_LENGTH()_** for a given string, multibyte characters are present.
  ```sql
  -- utf8: Has multibyte characters, but a given utf8 string might contain only single-byte characters.
  mysql> SET @s = CONVERT('abc' USING utf8);
  mysql> SELECT LENGTH(@s), CHAR_LENGTH(@s);
  +------------+-----------------+
  | LENGTH(@s) | CHAR_LENGTH(@s) |
  +------------+-----------------+
  | 3          | 3               |
  +------------+-----------------+

  -- ucs2: All characters are encoded using two bytes, even if they are single-byte characters.
  mysql> SET @s = CONVERT('abc' USING ucs2);
  mysql> SELECT LENGTH(@s), CHAR_LENGTH(@s);
  +------------+-----------------+
  | LENGTH(@s) | CHAR_LENGTH(@s) |
  +------------+-----------------+
  | 6          | 3               |
  +------------+-----------------+
  ```
- Another property of nonbinary strings is collation, which determines the sort order of characters in the character set.

  ```sql
  mysql> SHOW COLLATION LIKE 'latin1%';
  ```
  - A collation name ending in:
    - '_ci': case insensitive. 
    - '_cs': case sensitive. 
    - '_bin': binary.

- To determine a string's character set or collation, use the **_CHARSET()_**, **_COLATION()_**
- To change its character set, use the `CONVERT()` function.
- To change its collation, use th `COLLATE` operator.

  ```sql
  mysql> SELECT USER(), CHARSET(USER()), COLLATION(USER());

  -- String values take their character set and collation from the current configuration.
  mysql> SET NAMES 'latin1';
  mysql> SELECT CHARSET('abc'), COLLATION('abc');
  +----------------+-------------------+
  | CHARSET('abc') | COLLATION('abc')  |
  +----------------+-------------------+
  | latin1         | latin1_swedish_ci |
  +----------------+-------------------+

  -- Change properties of configuration
  mysql> SET NAMES utf8 COLLATE 'utf8_bin';
  mysql> SELECT CHARSET('abc'), COLLATION('abc');
  +----------------+------------------+
  | CHARSET('abc') | COLLATION('abc') |
  +----------------+------------------+
  | utf8           | utf8_bin         |
  +----------------+------------------+
  ```
- To change its character set, use the `CONVERT()` function.
  ```sql
  mysql> SET @s1 = _latin1 'my string', @s2 = CONVERT(@s1 USING utf8);
  mysql> SELECT CHARSET(@s1), CHARSET(@s2);
  +--------------+--------------+
  | CHARSET(@s1) | CHARSET(@s2) |
  +--------------+--------------+
  | latin1       | utf8         |
  +--------------+--------------+
  ```
- To change its collation, use th `COLLATE` operator.

  -- Convert a string from one character set to another
  mysql> SET @s1 = _latin1 'my_string', @s2 = CONVERT(@s1 USING utf8);

  -- Change collation of a string 
  mysql> SET @s1 = _latin1 'My String', @s2 = @s1 COLLATE latin1_spanish_ci;
  mysql> SELECT COLLATION(@s1), COLLATION(@s2);
  +-------------------+-------------------+
  | COLLATION(@s1)    | COLLATION(@s2)    |
  +-------------------+-------------------+
  | latin1_swedish_ci | latin1_spanish_ci |
  +-------------------+-------------------+

  -- Convert both
  mysql> SET @s1 = _latin1 'My String';
  mysql> SET @s2 = CONVERT(@s1 USING utf8) COLLATE utf8_spanish_ci;
  mysql> SELECT CHARSET(@s1), COLLATION(@s1), CHARSET(@s2), COLLATION(@s2);
  +--------------+-------------------+--------------+-----------------+
  | CHARSET(@s1) | COLLATION(@s1)    | CHARSET(@s2) | COLLATION(@s2)  |
  +--------------+-------------------+--------------+-----------------+
  | latin1       | latin1_swedish_ci | utf8         | utf8_spanish_ci |
  +--------------+-------------------+--------------+-----------------+
  ```

***

## Date And Times

| Data type | Storage  | Description   | Range
|-----------|----------|---------------|---------------------
| timestamp | 8 bytes  | Date and time | 4713 BC to 294276 AD
| date      | 4 bytes  | Date (no time)| 4713 BC to 5874897 AD
| time      | 8 bytes  | Time (no date)| 00:00:00 to 24:00:00
| interval  | 16 bytes | Time interval | +/− 178,000,000 years

* `timestamp`: Records date and time, which are useful for a range of situations. 
  - You might track: departures and arrivals of passenger flights, 
  - Schedule of Major League Baseball games, or incidents along a timeline. 
  - Typically, you’ll want to add the keywords with time zone to ensure that the time recorded for an event includes the time zone where it occurred. 
  - Otherwise, times recorded in various places around the globe become impossible to compare. 
  - The format timestamp with time zone is part of the SQL standard; with PostgreSQL you can specify the same data type using timestamptz .
* `date` : Records just the date.
* `time` : Records just the time. Again, you’ll want to add the with time zone keywords.
* `interval` : Holds a value representing a unit of time expressed in the format quantity unit . 
  - It doesn’t record the start or end of a time period, only its length. Examples include 12 days or 8 hours . 
  - The PostgreSQL documentation at https://www.postgresql.org/docs/current/static/datatype-datetime.html lists unit values ranging from microsecond to millennium .
  - You’ll typically use this type for calculations or filtering on other date and time columns.

  ```sql
  -- PGSQL
  pgsql> CREATE TABLE date_time_types (
             timestamp_column timestamp with time zone,
             interval_column interval
          );

  pgsql> SELECT timestamp_column, interval_column, timestamp_column - interval_column AS new_date FROM date_time_types ;
  ```

- `CAST(originalType AS anotherType)`: Transforming values from one type to another.
  ```sql
  pgsql> SELECT timestamp_column, CAST(timestamp_column AS varchar(10)) FROM date_time_types;
  pgsql> SELECT numeric_column, CAST(numeric_column AS integer), CAST(numeric_column AS varchar(6)) FROM number_data_types;

  -- CAST alias '::'
  pgsql> SELECT timestamp_column::varchar(10) AS "varcharDate" FROM date_time_types;
  ```
