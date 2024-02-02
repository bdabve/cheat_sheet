<link rel="stylesheet" href="style.css">

# <center>Selecting Data</center>

## Table of Content

* [Getting Started](#getting-started)
* [Le Cas Null](#le-cas-null)
* [Eliminer Les Doublons](#eliminer-les-doublons)
* [Patterns Matching](#patterns-matching)
* [Recherche dans un intervalle](#recherche-dans-un-intervalle)
* [Regular Expressions](#regular-expressions)
* [Breaking Apart or Combining Strings](#breaking-apart-or-combining-strings)
* [Searching For Substrings](#searching-for-substrings)

***

* [Linux Main](file:///home/dabve/web_dev/sql/mySql/linux_main.md)
* [Windows Main]()

### Getting Started

  ```sql
  mysql> SELECT * FROM mail;
  mysql> SELECT srcuser, srchost, t, size FROM mail;

  mysql> SELECT DATE_FORMAT(t,'%M %e, %Y'), CONCAT(srcuser,'@',srchost), size FROM mail;
  ```

- `WHERE`

  ```sql
  mysql> SELECT t, srcuser, srchost FROM mail WHERE srchost = 'venus'.
  mysql> SELECT t, srcuser, srchost FROM mail WHERE srchost LIKE '%s';

  mysql> SELECT * FROM mail WHERE srcuser = 'barb' AND dstuser = 'tricia';
  mysql> SELECT t, CONCAT(srcuser,'@',srchost), size FROM mail;
  mysql> SELECT DATE_FORMAT(t, '%M %e, %Y') AS date_sent, CONCAT(srcuser,'@',srchost) AS sender, size FROM mail;
  mysql> SELECT DATE_FORMAT(t, '%M %e, %Y') AS 'Date of message', CONCAT(srcuser,'@',srchost) AS 'Message sender', size FROM mail;

  mysql> SELECT * FROM Animal WHERE data_naissance < '2008-01-01';           -- Animal née avant 2008
  mysql> SELECT * FROM Animal WHERE espece <> 'chien'                        -- Tous les animaux sauf les chiens

  mysql> SELECT * FROM Animal WHERE espece='chat' AND sexe='F';              -- Toutes les chattes.
  mysql> SELECT * FROM Animal WHERE espece='chat' && sexe='F';               -- && == AND

  mysql> SELECT * FROM Animal WHERE espece='tortue' OR espece='perroquet';
  mysql> SELECT * FROM Animal WHERE espece='tortue' || espece='perroquet';   -- || == OR

  -- Sélection de tous les animaux femelles sauf les chiennes.
  mysql> SELECT * FROM Animal WHERE sexe='F' AND NOT espece='chien';
  mysql> SELECT * FROM Animal WHERE sexe='F' AND ! espece='chien';

  -- Sélection des animaux qui sont soit des mâles, soit des perroquets (mais pas les deux).
  mysql> SELECT * FROM Animal WHERE sexe='M' XOR espece='perroquet';
  mysql> SELECT * FROM Animal WHERE date_naissance > '2009-12-31'
         OR (espece='chat' AND (sexe='M' OR (sexe='F' AND date_naissance < '2007-06-01')))
  ```

* Les opérateurs de comparaison

  | Opérateur | Signification
  |-----------|------------------
  | =         | égal
  | <         | inférieur
  | <=        | inférieur ou égal
  | >         | supérieur
  | >=        | supérieur ou égal
  | <> ou !=  | différent
  | <=>       | égal (valable pour NULL aussi)

[*Return to the Top*](#table-of-content)

### Le cas NULL

* `<=>`: qui permet de reconnaître NULL.
    
  ```sql
  mysql> SELECT * FROM Anima WHERE nom <=> NULL;                  -- Les animaux sans nom
  mysql> SELECT * FROM Animal WHERE nom IS NULL;
  mysql> SELECT * FROM Animal WHERE commentaires IS NOT NULL;
  ```

* This `IF()` based mapping technique works for any kind of value, but it’s especially useful with `NULL` values because `NULL` tends to be given a variety of meanings: `unknown`, `missing`, `not yet determined`, `out of range`, and so forth. 
*  `IFNULL()`, which tests its first argument and returns it if it’s not NULL, or returns its second argument otherwise.
* Choose the label that makes the most sense in a given context.

  ```sql
  mysql> SELECT name, IF(date_naissance IS NULL, 'Not Determined', date_naissance) AS date_naissance FROM Animal;
  mysql> SELECT name, IFNULL(date_naissance, 'Not Determined') AS date_naissance FROM Animal;
  mysql> SELECT subject, test, IF(score IS NULL,'Unknown', score) AS 'Score' FROM expt;
  ```

[*Return to the Top*](#table-of-content)

### Eliminer Les Doublons:

* `DISTINCT`: Ce mot-clé se place juste après SELECT et permet d'éliminer les doublons.

  ```sql
  mysql> SELECT DISTINCT espece FROM Animal;
  mysql> SELECT COUNT(DISTINCT espece) FROM mail;
  ```

* `LIMIT` With `OFFSET`: A partir de quell ligne on récupère les résultats.

  ```sql
  mysql> SELECT * FROM Animal ORDER BY id LIMIT 6 OFFSET 0;
  mysql> SELECT * FROM Animal ORDER BY id LIMIT 10;
  mysql> SELECT * FROM Animal ORDER BY id LIMIT 6 OFFSET 3;   --  décalage de trois lignes. En commence au quatrième
  mysql> SELECT * FROM Anima ORDER BY id LIMIT 3, 2;          -- décalage de 3 colonne , En commence au quatriéme
  ```

***

[*Return to the Top*](#table-of-content)

## Patterns Matching

* SQL pattern matchin uses the **_LIKE_** and **_NOT LIKE_** operators.

    - `'_'`    : Matches any single character. 
    - `'%'`   : Matches any sequince of characters,including the empty string.

    - `'%me'`   : Strings that begin with a particular substring ('mercury', 'merings', 'me')
    - `'%d'`    : String that end with a particular substring ('gold', 'lead', 'd')
    - `'%in%'`  : String that contain a particular substring at any position ('platinum', 'tin').
    - `'%ch%ne'`: 'chne', 'chine', 'échine', 'pays le plus peuplé du monde est la Chine'

    - `'__at%'` : String that contain a substring at a specific position (platinum)
    - `'_ch_ne'`: 'chine', 'chne', 'echine'

  ```sql
  SELECT * FROM Animal WHERE commentaires LIKE '%\%%';    -- Echape % pour le chercher
  SELECT * FROM Animal WHERE nom NOT LIKE '%a%';          -- Exclure une chaine de la recherche.
  SELECT * FROM Animal WHERE nom LIKE '%Lu%';             -- Insensible à la casse
  SELECT * FROM Animal WHERE nom LIKE BINARY '%Lu%';      -- Sensible à la casse

  SELECT * FROM Animal WHERE id LIKE '1%';                -- Avec des chiffre.
  ```

[*Return to the Top*](#table-of-content)

### Recherche dans un intervalle:

* `IN`: vous permet de faire des recherches parmi une liste de valeurs.
    
    ```sql
    SELECT * FROM Animal WHERE date_naissance BETWEEN '2008-01-05' AND '2009-03-23';
    SELECT * FROM Animal WHERE nom IN ('Moka', 'Bilba', 'Tortilla', 'Balou', 'Dana', 'Redbul', 'Gingko');
    ```

[*Return to the Top*](#table-of-content)

### Regular Expressions

| Pattern | What the pattern matches
| --------|----------------------------
| ^       | Beginning of string
| $       | End of string
| .       | Any single character
| [...]   | Any character listed between the square brackets
| [^...]  | Any character not listed between the square brackets
| p1|p2|p3| Alternation; matches any of the patterns p1 , p2 , or p3
| *       | Zero or more instances of preceding element
| +       | One or more instances of preceding element
| {n}     | n instances of preceding element
| {m,n}   | m through n instances of preceding element


```sql
mysql> SELECT name FROM metal WHERE name REGEXP '^me';  -- Begin with a particular substring
mysql> SELECT name FROM metal WHERE name REGEXP 'd$';   -- End with a particular substring
mysql> SELECT name FROM metal WHERE name REGEXP 'in';   -- Containt a particular substring at any position

mysql> SELECT name FROM metal WHERE name REGEXP '^...at';   -- Containt a particular substring at a specific position
```

[*Return to the Top*](#table-of-content)

### Breaking Apart or Combining Strings

```sql
mysql> SET @date = '2015-07-21';
mysql> SELECT @date, LEFT(@date, 4) AS Year,
    -> MID(@date, 6, 2) AS Month, RIGHT(@date, 2) AS Day;
```

* The `SUBSTRING()` function takes a string and a starting position, returning everything to the right of the position. 
* `MID()` acts the same way if you omit its third argument because `MID()` is actually a synonym for `SUBSTRING()`

  ```sqL
  MYSQL> SET @DATE = '2015-07-21';
  MYSQL> SELECT @DATE, SUBSTRING(@DATE, 6), MID(@DATE, 6);  // Returning the same result: 07-21
  ```

* `SUBSTRING_INDEX(str, c, n)` : To return everything to the right or left of a givin Character.
  * It search into a string `str` for the `n`-th occurrence of the character `c` and return everything to its left.
  * If `n` is negative, the search for `c` starts from the right and returns everything to the right of characters.
  
  ```sql
  mysql> SET @mail = 'email@exemple.com';
  mysql> SELECT @email,
      -> SUBSTRING_INDEX(@email, '@', 1) AS user,
      -> SUBSTRING_INDEX(@email, '@', -1) AS host;
  ```

* To conbine rather than pull apart strings, use the `CONCAT()` function.
* It concatenates its arguments and returns the result

  ```sql
  mysql> SELECT CONCAT(name, ' ends in "d": ', IF(RIGHT(name,1)='d', 'YES', 'NO'))
      -> AS 'ends in "d"?' FROM metal;

  -- Useful modifying
  mysql> UPDATE metal SET name = CONCAT(name, 'ide'); 

  -- Undo changes
  mysql> UPDATE metal SET name = LEFT(name, CHAR_LENGTH(name)-3);
  ```

[*Return to the Top*](#table-of-content)

### Searching for Substrings

* `LOCATE()`: function takes two arguments
  * Substrings that you're looking for.
  * And the string in chich to look for it.
  * The return value is the position of substrings, or 0 if it's not present.
  * An optional third argumant may be given to indicate the position within the string at with to start looking.

  ```sql
  mysql> SELECT name, LOCATE('in', name), LOCATE('in', name, 3) FROM metal
  
  -- If you don’t care about its position, an alternative is to use LIKE or REGEXP
  mysql> SELECT name, name LIKE '%in%', name REGEXP 'in' FROM metal;
  ```

[*Return to the Top*](#table-of-content)
