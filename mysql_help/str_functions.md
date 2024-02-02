# <center>STRING FUNCTIONS</center>


* [Number Functions](#numFunctions)

### Fonctions scalaires vs fonctions d'agrégation

* Les fonctions **scalaires** s'appliquent à chaque ligne indépendamment, tandis que les fonctions **d'agrégation** regroupent les lignes (par défaut, elles regroupent toutes les lignes en une seule).

* **_USER()_**          :  Renvoie l'utilisateur (et l'hôte) qui a été spécifié lors de l'identification au serveur.
* **_CURRENT_USER()_**  : Renvoie l'utilisateur (et l'hôte) qui a été utilisé lors de l'identification au serveur 
* **_VERSION()_**       : Savoir sous quelle version de MySQL tourne votre serveur.
* **_LAST_INSERT_ID()_**: Cette fonction renvoie le dernier id créé par auto-incrémentation, pour la connexion utilisée
* **_FOUND_ROWS()_**    : Permet d'afficher le nombre de lignes que votre dernière requête a ramenées.

  ```sql
  mysql> SELECT id, nom, espece_id, prix FROM Race;
  mysql> SELECT FOUND_ROWS();
      -> 8
  ```

* **_LEFT(string, length)_**            : Return the left most number of characters as specified in length.
* **_MID(string, position, length)_**   : Return a substring starting from the specified position.  
* **_RIGHT(string, length)_**           : Return the rightMost number of characters as specified in length. 
* **_SUBSTRING(string, satrt_pos)_**    : (Scalaire) Return everythin to the right, MID() acts the same way if you omit the 3 arg.

  ```sql
  mysql> SET @date = '2015-07-21'
  mysql> SELECT @date, LEFT(@date,4) AS year,
      -> MID(@date,6,2) AS month, 
      -> RIGHT(@date,2) AS day;
  +------------+------+-------+------+
  | @date      | year | month | day  |
  +------------+------+-------+------+
  | 2015-07-21 | 2015 | 07    | 21   |
  +------------+------+-------+------+

  mysql> SELECT @date, SUBSTRING(@date,6), MID(@date,6);
  +------------+--------------------+--------------+
  | @date      | SUBSTRING(@date,6) | MID(@date,6) |
  +------------+--------------------+--------------+
  | 2015-07-21 | 07-21              | 07-21        |
  +------------+--------------------+--------------+

  -- Finds metal names having a first letter that lies in the last half of the alphabet
  mysql> SELECT name FROM metal WHERE LEFT(name, 1) >= 'n'; 

  -- Combine with CONCAT.
  mysql> SELECT CONCAT(name,' ends in "d": ',IF(RIGHT(name,1)='d','YES','NO')) AS 'ends in "d"?'
      -> FROM metal;

  -- UPDATE with LEFT. 
  mysql> UPDATE metal SET name = CONCAT(name,'ide');
  mysql> UPDATE metal SET name = LEFT(name, CHAR_LENGTH(name)-3); 
  ```

- **_SUBSTRING_INDEX(str, char, number)_**: It searches into a 'string' for the 'number' of occurrence of the character 'char'
  ```sql
  mysql> SET @email = 'postmaster@example.com';
  mysql> SELECT @email,
      -> SUBSTRING_INDEX(@email,'@',1) AS user,
      -> SUBSTRING_INDEX(@email,'@',-1) AS host;
  +-----------------+-------+-----------+
  | @email          | user  | host      |
  +-----------------+-------+-----------+
  | dabve@email.com | dabve | email.com |
  +-----------------+-------+-----------+
  ```

* **_LOCATE(substr, string, [position])_**: (scalaire) Return the position at which the substring occurs, or 0 if it's not present.
  ```sql
  mysql> SELECT name, LOCATE('in', name), LOCATE('in', name, 3) FROM metal;
  +----------+--------------------+---------------------+
  | name     | LOCATE('in', name) | LOCATE('in',name,3) |
  +----------+--------------------+---------------------+
  | gold     | 0                  | 0                   |
  | iron     | 0                  | 0                   |
  | lead     | 0                  | 0                   |
  | mercury  | 0                  | 0                   |
  | platinum | 5                  | 5                   |
  | tin      | 2                  | 0                   |
  +----------+--------------------+---------------------+
  ```

* `BIT_LENGTH`: (scalaire) Le nombre de bits de la chaine.

  ```sql
  mysql> SELECT BIT_LENGTH('élevage');
      -> 64
  ```

* `LENGTH(str)`: (scalaire) Returns the length of the string str, measured in bytes. A multibyte character counts as multiple bytes. This means that for a string containing five 2-byte characters, LENGTH() returns 10, whereas CHAR_LENGTH() returns 5.  
  ```sql
  mysql> SELECT LENGTH('text');
      -> 4
  ```

* `CHAR_LENGTH(str)`: Returns the length of the string str, measured in characters.  

  ```sql
  mysql> SELECT CHAR_LENGTH('text');
      -> 4

  -- Les Chiens dont le nom a un pair de lettres
  mysql> SELECT nom FROM Animal INNER JOIN Espece ON Animal.espece_id = Espece.id 
      -> WHERE Espece.nom_courant LIKE 'Chien%' AND CHAR_LENGTH(nom) % 2 = 0; 
  ```

* `UCASE(str), LCASE(str)`: is a synonym for UPPER() and LOWER().  

  ```sql
  mysql> SELECT UCASE('dabve');
      -> DABVE
  mysql> SELECT LCASE('DABVE');
      -> dabve
  ```
  - But some strings are 'Stubborn' and resist lettercase conversion:
  - This problem occurs for strings that have a BINARY or BLOB data type.
  - To map a binary string to a given lettercase, convert it to a nonbinary string, choosing a character set
    ```sql
    mysql> CREATE TABLE t(b BLOB) SELECT 'aBcD' AS b;
    mysql> SELECT b, UPPER(b), LOWER(b) FROM t;
    +------+----------+----------+
    | b    | UPPER(b) | LOWER(b) |
    +------+----------+----------+
    | aBcD | aBcD     | aBcD     |
    +------+----------+----------+

    mysql> SELECT b, UPPER(CONVERT(b USING latin1)) AS upper, LOWER(CONVERT(b USING latin1)) AS lower FROM t;
    +------+-------+-------+
    | b    | upper | lower |
    +------+-------+-------+
    | aBcD | ABCD  | abcd  |
    +------+-------+-------+
    ``` 

* `REPEAT(str, count)`: (scalaire) Returns a string consisting of the string ``str`` repeated ``count`` times. 
* If count is less than 1, returns an empty string. Returns NULL if str or count are NULL
  
  ```sql
  mysql> SELECT REPEAT('MySQL ', 3);
      -> MySQL MySQL MySQL
  ```
  
* `REPLACE(str, from_str, to_str)`: Returns the string str with all occurrences of the string `from_str` replaced by the string `to_str`. 
  * `REPLACE()`: performs a case-sensitive match when searching for from_str.

  ```sql
  mysql> SELECT REPLACE('Mysql', 'ysql', 'YSQL');
      -> MYSQL

  -- Noms des perroquets en remplaçant les 'a' par @ et les 'e' par '3'
  mysql> SELECT REPLACE(REPLACE(nom, 'a', '@'), 'e', '3') FROM Animal 
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id WHERE Espece.nom_courant LIKE 'Perroquet%';
  ```
  
* `REVERSE(str)`: (scalaire) Reverse the characters in a string.

  ```sql
  mysql> SELECT REVERSE('DABVE');
      -> EVBAD
  ```

* `FIELD(rech, chaine1, chaine2, ...)`: (scalaire) Recherche le premier argument parmis les argument suivant

  ```sql
  mysql> SELECT FIELD('dabve', 'Dabve hear', 'not', 'dabve', 'dabve admin', 'admin');
      -> 3
  ```

* `ASCII()`, `CHAR()`: (scalaire) Le code ascii corespondant aux char, ou le char corespendant aux codes ascii 

  ```sql
  mysql> SELECT ASCII('T');
    -> 84
  mysql> SELECT CHAR('84');
    -> T
  ```

* `CONCAT(str, str1, ..)`: Returns the string that results from concatenating the arguments. May have one or more arguments. If all arguments are nonbinary strings, the result is a nonbinary string. If the arguments include any binary strings, the result is a binary string. A numeric argument is converted to its equivalent nonbinary string form.

* `CONCAT()` returns NULL if any argument is NULL.
  
  ```sql
  mysql> SELECT CONCAT('My', 'S', 'QL');
      -> 'MySQL'
  mysql> SELECT CONCAT('My', NULL, 'QL');
      -> NULL
  mysql> SELECT CONCAT(14.3);
      -> '14.3'
  ```
  
* `CONCAT_WS(separator, str1, str2, ...)`: Stands for Concatenate With Separator and is a special form of `CONCAT()`. The first argument is the separator for the rest of the arguments. The separator is added between the strings to be concatenated. The separator can be a string, as can the rest of the arguments. If the separator is `NULL`, the result is `NULL`.

* `CONCAT_WS()` does not skip empty strings. However, it does skip any `NULL` values after the separator argument.

  ```sql
  mysql> SELECT CONCAT_WS(',','First name','Second name','Last Name');
      -> 'First name,Second name,Last Name'
  mysql> SELECT CONCAT_WS(',','First name',NULL,'Last Name');
      -> 'First name,Last Name'
  ```
  
* `INSERT(str,pos,len,newstr)`: Returns the string str, with the substring beginning at position pos and len characters long replaced by the string newstr. Returns the original string if pos is not within the length of the string. Replaces the rest of the string from position pos if len is not within the length of the rest of the string. Returns `NULL` if any argument is `NULL`.

  ```sql
  mysql> SELECT INSERT('Quadratic', 3, 4, 'What');
      -> 'QuWhattic'
  mysql> SELECT INSERT('Quadratic', -1, 4, 'What');
      -> 'Quadratic'
  mysql> SELECT INSERT('Quadratic', 3, 100, 'What');
      -> 'QuWhat'
  ```

* `STRCMP(str1, str2)`: (scalaire function) Compare two strings.

  ```sql
  mysql> SELECT STRCMP('str', 'str');
      -> 0
  mysql> SELECT STRCMP('str1', 'str');
      -> 1
  mysql> SELECT STRCMP('str1', 'strstr');
      -> -1
  ```
  
* `TRIM([[BOTH | LEADING | TRAILING] [caract] FROM] texte)`: (scalaire) Supprimer tous ces caractères unitile.

  ```sql
  mysql> SELECT TRIM('   str   ');
      -> str
  mysql> SELECT TRIM(LEADING 'e' FROM 'eeebougeee');    -- LEADING: Caractère a l'avant
      -> bougeee
  mysql> SELECT TRIM(TRAINLING 'e' FROM 'eeebougeee');  -- TRAILING: Caractère a l'arrière 
      -> eeeboug
  mysql> SELECT TRIM(BOTH '123' FROM '123abc123');      -- BOTH: both
      -> abc
  ```


* `INSTR(chaine, rech)`: (scalaire) La position de la première occurrence d'une chaîne de caractères rech dans une chaîne de caractères chaine.

  ```sql
    mysql> SELECT INSTR('tralala', 'la') AS fct_INSTR;
        -> 4    
  ```


* `POSITION(rech IN chaine)`: (scalaire) La position de la première occurrence d'une chaîne de caractères rech dans une chaîne de caractères chaine.
  ```sql
  mysql>SELECT POSITION('la' IN 'tralala') AS fct_POSITION;
      -> 4 
  ```

* [ALL STRING FUNCTIONS.](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html)


<a name="numFunctions"/>

# <center>NUMBER FUNCTIONS</center>

* `CEIL(n)` ou `CEILING(n)`: (scalaire) Arrondit au nombre entier supérieur.
  ```sql
  mysql -> SELECT CEIL(3.2), CEIL(3.7);
        -> 4 4
  ```

* `FLOOR(n)` : (scalaire) Arrondit au nombre entier inférieur.
  ```sql
  mysql -> SELECT FLOOR(3.7);
        -> 3
  ```

* `ROUND(n, d)`: (fonciont scalaire) Arrondit au nombre à d décimales le plus proche.
  ```sql
  mysql -> SELECT ROUND(3.22, 1), ROUND(3.55, 1), ROUND(3.77, 1);
        -> 3.2 3.6 3.8
  mysql -> SELECT ROUND(3.2), ROUND(3.5), ROUND(3.7);
        -> 3 4 4  
  ```

* `TRUNCATE(n, d)`: (scalaire) Arrondit en enlevant purement et simplement les décimales en trop (donc arrondi à l'inférieur pour les nombres positifs, au supérieur pour les nombres négatifs).

  ```sql
  mysql -> SELECT TRUNCATE(3.2, 0), TRUNCATE(3.5, 0), TRUNCATE(3.7, 0);
        -> 3 3 3
  mysql -> SELECT TRUNCATE(3.22, 1), TRUNCATE(3.55, 1), TRUNCATE(3.77, 1);
        -> 3.2 3.5 3.7  
  ```

* `POWER(n, e)` ou `POW(n, e)` (scalaire) retourne le résultat de n exposant e.

  ```sql
  mysql -> SELECT POW(2, 5), POWER(5, 2);
        -> 32 25  
  ```

* `SQRT(n)`: (scalaire) Donne la racine carrée positive de n 

  ```sql
  mysql -> SELECT SQRT(4);
        -> 2  
  ```
  
* `ABS(n)`: (scalaire) Retourne la valeur absolue de n, donc sa valeur sans le signe.
  ```sql
  mysql -> SELECT ABS(-43), ABS(0), ABS(37);
        -> 43 0 37  
  ```
  
* `MOD(n, div)`:(scalaire) retourne le modulo, donc le reste de la division entière de n par div (comme l'opérateur % ou MOD)
  ```sql
  mysql -> SELECT MOD(56, 10);
        -> 6  
  -- Les chiens dont le nom a un nombre pair de lettres
  mysql> SELECT nom, nom_courant FROM Animal
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id
      -> WHERE nom_courant = 'Chien' AND MOD(CHAR_LENGTH(nom), 2) = 0
  ```

* `LPAD`, `RPAD`: (scalaire) La chaine a transformer, la longuer, et le caract-re a ajouter si la chaine est trop courte.

  ```sql
  mysql> LPAD('text', 3, '$'), LPAD('text', 6, '$');
      -> tex, $text

  -- Useful example
  mysql> SET @price = 1000;
  mysql> SELECT LPAD(@price, CHAR_LENGTH(@price) + 1, '$'); -- RPAD(@price, CHAR_LENGTH(@price) + 1, '$') -> 1000$
      -> $1000

  mysql> RPAD('text', 3, '$'), RPAD('text', 6, '$');
  mysql> tex, text$
  ```
    
* `GROUP_CONCAT(nom_colonne)`: Cette fonction concatène les valeurs de nom_colonne pour chaque groupement réalisé.
  
  ```sql
  GROUP_CONCAT(
            [DISTINCT] col1 [, col2, ...]
            [ORDER BY col [ASC | DESC]]
            [SEPARATOR sep]
          )
  ```
  
  * DISTINCT : sert comme d'habitude à éliminer les doublons.
  * col1 : est le nom de la colonne dont les valeurs doivent être concaténées. C'est le seul argument obligatoire.
  * col2,… : sont les éventuelles autres colonnes (ou chaînes de caractères) à concaténer.
  * ORDER BY : permet de déterminer dans quel ordre les valeurs seront concaténées.
  * SEPARATOR : permet de spécifier une chaîne de caractères à utiliser pour séparer les différentes valeurs. Par défaut, c'est une virgule.

  ```sql
  -- --------------------------------------
  -- CONCATENATION DE PLUSIEURS COLONNES --
  -- --------------------------------------
  SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, Espece.nom_courant)
  FROM Race
  INNER JOIN Espece ON Espece.id = Race.espece_id;

  -- ---------------------------------------------------
  -- CONCATENATION DE PLUSIEURS COLONNES EN PLUS JOLI --
  -- ---------------------------------------------------
  SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')')
  FROM Race
  INNER JOIN Espece ON Espece.id = Race.espece_id;

  -- ---------------------------
  -- ELIMINATION DES DOUBLONS --
  -- ---------------------------
  SELECT SUM(Espece.prix), GROUP_CONCAT(DISTINCT Espece.nom_courant) 
      -- Essayez sans le DISTINCT pour voir
  FROM Espece
  INNER JOIN Race ON Race.espece_id = Espece.id;

  -- --------------------------
  -- UTILISATION DE ORDER BY --
  -- --------------------------
  SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')' ORDER BY Race.nom DESC)
  FROM Race
  INNER JOIN Espece ON Espece.id = Race.espece_id;

  -- ----------------------------
  -- CHANGEMENT DE SEPARATEUR  --
  -- ----------------------------
  SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')' SEPARATOR ' - ')
  FROM Race
  INNER JOIN Espece ON Espece.id = Race.espece_id;
  ```

