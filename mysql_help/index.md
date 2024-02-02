# <center>INDEXES</center>

#### Table of Contents:
* [**_PRIMARY KEY_**](#primary_key)
* [**_FOREIGN KEY_**](#foreign_key)
* [**_UNIQUE_**](#unique)
* [**_FULLTEXT INDEX_**](#fulltext)

## Speeding Up Queries with Indexes

- In the same way that a book's index helps you find information more quickly, you can speed up queries by adding index.
- The database uses index as a shortcut rather than scanning each row to find data.
- Indexes are stored separately from the table data, but they're accessed automatically when you run a quiry and are updated every time a row is added or removed from the table.

#### B-Tree: PostgreSQL's Default Index

- In PostgreSQL, the default index type is the **_B-Tree_** index, it's created automatically on the columns designated for the primary key or a UNIQUE constraint, and it's also the type created by default when you execute a **_CREATE INDEX_** statement

- The **_EXPLAIN_** command provides output that lists the query plan for a specific database query. 
- This might include how the database plans to scan the table, whether or not it will use indexes, and so on.
- If we add the **_ANALYZE_** keyword, **_EXPLAIN_** will carry out the query and show the actual execution time, which is what we want for the current exercise.
- **_EXPLAIN_** is specific to PostgreSQL and not part of standard SQL.

  ```sql
  psql> EXPLAIN ANALYZE SELECT * FROM new_york_addresses WHERE street = 'BROADWAY'

  -- Adding a B-Tree index
  psql> CREATE INDEX street_idx ON new_york_addresses(street);
  ```
## Les différents types d'index:

* En plus des index 'simples', il existe trois types d'index qui ont des propriétés particulières.
  * `UNIQUE` 
  * `FULLTEXT`
    * Une différence très importante entre les index `FULLTEXT` et les index classiques (et `UNIQUE`) est que l'on ne peut plus utiliser les fameux 'index par la gauche'. 
    * Donc, si vous voulez faire des recherches 'fulltext sur deux colonnes (parfois l'une, parfois l'autre, parfois les deux ensemble), il vous faudra créer trois index  
    * `FULLTEXT` : (colonne1), (colonne2) et (colonne1, colonne2).

  * `SPATIAL`: il s'agit d'un type d'index utilisé dans des bases de données recensant des données spatiales, donc des points, des lignes, des polygones…

## Création et suppression des index Simple:

- Les index sont représentés par le mot-clé `INDEX` ou `KEY` et peuvent être créés de deux manières :
    
1. soit directement lors de la création de la table: Ici aussi, deux possibilités
  ```sql
  CREATE TABLE nom_table (
      colonne1 INT KEY,                  		    -- Crée un index simple sur colonne1
      colonne2 VARCHAR(40) UNIQUE               -- Crée un index unique sur colonne2
      );

  CREATE TABLE Animal (
      id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
      espece VARCHAR(40) NOT NULL,
      sexe CHAR(1),
      date_naissance DATETIME NOT NULL,
      nom VARCHAR(30),
      commentaires TEXT,
      PRIMARY KEY (id),                              -- Declaration aprés la description des colonne.
      INDEX ind_date_naissance (date_naissance),  	 -- index sur la date de naissance
      INDEX ind_nom (nom(10))                        -- le chiffre entre parenthèses étant le nombre de caractères pris en compte
      UNIQUE INDEX ind_uni_nom_espece (nom, espece)) -- Index sur le nom et l'espece
  ENGINE=INNODB;
  ```

2. Soit en les ajoutant par la suite. 
  * Il existe deux commandes permettant de créer des index sur une table existante : `ALTER TABLE`, et `CREATE INDEX`. équivalentes
    ```sql
    ALTER TABLE Test_tuto ADD INDEX ind_nom(nom);
    CREATE INDEX ind_nom ON Test_tuto(nom);          -- Equivalant de la precedent

    mysql> CREATE INDEX nom_index ON nom_table (colonne_index [, colonne2_index ...]);	         --  Crée un index simple
    mysql> CREATE UNIQUE INDEX nom_index ON nom_table (colonne_index [, colonne2_index ...]);    -- Crée un index UNIQUE
    mysql> CREATE FULLTEXT INDEX nom_index ON nom_table (colonne_index [, colonne2_index ...]);  -- Crée un index FULLTEXT
    mysql> ALTER TABLE nom_table DROP INDEX nom_index;		                                     --  Suppression de l'index
    ```

## Show Indexes:

  ```sql
  mysql> SHOW INDEXES FROM table_name;
  ```

***

<a name='primary_key'/>

## <center>Primary Keys</center>

- **_PRIMARY KEY_**: is a constraint, and it imposes two rules on the columns or columns that make up the key:
  - Each column in the key must have a unique value for each row.
  - No column in the key can heve missing values.
- Also provide a means of relatin tables to each other and maintaining `referential integrity`. 

### Create PRIMARY KEYS

```sql
mysql> CREATE TABLE Animal (
    ->     id SMALLINT AUTO_INCREMENT PRIMARY KEY,     -- column constrant syntax, easy to understand.
    ->     nom VARCHAR(30),
    -> ) ENGINE=InnoDB;

mysql> CREATE TABLE Animal (
    ->     id SMALLINT AUTO_INCREMENT,
    ->     nom VARCHAR(30),
    ->     PRIMARY KEY (id)                            -- table constraint syntax.
    -> ) ENGINE=InnoDB;

-- PostgresSQL

psql> CREATE TABLE natural_key_exaple(
   ->     license_id VARCHAR(10) CONSTRAINT license_key PRIMARY KEY,  -- easy to understand.
   ->     fname VARCHAR(50),
   ->     lname VARCHAR(50),
   -> );

psql> CREATE TABLE natural_key_exaple(
   ->     license_id VARCHAR(10),
   ->     fname VARCHAR(50),
   ->     lname VARCHAR(50),
   ->     CONSTRAINT license_key PRIMARY KEY(licence_id),
   -> );
```

- Creating a Composite **_PRIMARY KEY_**: multiple primary key.
  ```sql
  psql> CREATE TABLE natural_key_composite_example(
     ->     student_id VARCHAR(10)
     ->     school_day DATE,
     ->     present BOOLEAN,
     ->     CONSTRAINT student_key PRIMARY KEY(student_id, school_day)
     -> );
  ```

- After creating the table

  ```sql
  mysql> ALTER TABLE table_name ADD [CONSTRAINT [constraint_name]] PRIMARY KEY(column1[, colonne_pk2, ...]);
  mysql> ALTER TABLE Animal ADD PRIMARY KEY id;
  psql> ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY(column)
  ```

- Droping 
  ```sql
  mysql> ALTER TABLE table_name DROP PRIMARY KEY;
  ```

* Print keys
  ```sql
  mysql> SHOW INDEX FROM tableName;
  ```
  
### AUTO_INCREMENT

* The `AUTO_INCREMENT` keyword informs MySQL that it should generate successive sequence numbers for the column’s values, but the other information is important, too:
  * `AUTO_INCREMENT` columns cannot contain `NULL` values. so columns is declared as `NOT NULL`.
  * Should be one of the integer types: `TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, or `BIGINT`.
  * `UNSIGNED` prohibits negative column values. 
  * This is not a required attribute for `AUTO_INCREMENT` columns, but sequences consist only of positive integers (normally beginning at 1), so there is no reason to permit negative values.
  
* The following table shows the maximum _**unsigned**_ value of each type

| Data type     | Maximum unsigned value
|---------------|---------------------------------
| TINYINT       | 255
| SMALLINT      | 65,535
| MEDIUMINT     | 16,777,215
| INT           | 4,294,967,295
| BIGINT        | 18,446,744,073,709,551,615

- To use an AUTO_INCREMENT value in **_PGSQL_**, we use the 
- **_SMALLSERAIL_**, **_SERIAL_** and **_BIGSERIAL_** wich correspond to **_SMALLINT_**, **_INTEGER_**, **_BIGINT_** types.

  | Data type     | Storage size  | Range
  |---------------|---------------|-----------------
  | smallserial   | 2 bytes       | 1-32767
  | serial        | 4 bytes       | 1-214783647
  | bigserial     | 8 bytes       | 1-9223372036854775807

### Dealing with **_id_**

- It’s common for applications to need to know the `AUTO_INCREMENT` value of a newly created row. 
  ```sql
  mysql> SELECT LAST_INSERT_ID();
  -- With PHP PDO 
  $saq = $dbh->lastInsertId();
  ```

- **Renumbering an Existing Sequence**

  ```sql
  mysql> ALTER TABLE insect DROP id;
  mysql> ALTER TABLE insect ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (id);
  ```

- **Resequencing an AUTO_INCREMENT** 
  - Changes the contents of potentially every row in the table. 
  - It’s often possible to avoid this by extending the range of the column, which changes the table’s structure rather than its contents:

  ```sql
  -- Suppose that an id column currently is defined like this:
  id MEDIUMINT NOT NULL AUTO_INCREMENT

  -- To increase this to 16,777,215, make the column UNSIGNED with ALTER TABLE:
  mysql> ALTER TABLE tbl_name MODIFY id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT;

  -- Converting it to a larger type increases its range.
  mysql> ALTER TABLE tbl_name MODIFY id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT;
  ```

***
<a name='foreign_key'/>

## <center>Foreign Keys</center>

- _foreign key_ provides a way to ensure data in related tables doesn't end up unrelated, or orphaned.
- A _forein_key_ is one or more columns in a table that match the primary key of another table.
- This constraint ensures that we don't end up with rows in one table that have no relation to rows in the other tables.

### Creation:
- **_MySQL_**
  ```sql
  mysql> CREATE TABLE Commande (
      ->     numero INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
      ->     client INT UNSIGNED NOT NULL,
      ->     produit VARCHAR(40),
      ->     quantite SMALLINT DEFAULT 1,
      ->     CONSTRAINT fk_client_numero             -- On donne un nom à notre clé
      ->         FOREIGN KEY (client)                -- Colonne sur laquelle on crée la clé
      ->         REFERENCES Client(numero)           -- Colonne de référence
      -> ) ENGINE=InnoDB;                            -- MyISAM interdit.
  ```
- **_PgSQL**
  ```sql
  psql> CREATE TABLE licenses (
     ->     license_id varchar(10),
     ->     first_name varchar(50),
     ->     last_name varchar(50),
     ->     CONSTRAINT licenses_key PRIMARY KEY (license_id));

  psql> CREATE TABLE registrations (
     ->     registration_id varchar(10),
     ->     registration_date date,
     ->     license_id varchar(10) REFERENCES licenses (license_id),               -- Foreing key
     ->     CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id));
  ```

* Après création de la table:
  ```sql
  ALTER TABLE Commande ADD CONSTRAINT fk_client_numero FOREIGN KEY (client) REFERENCES Client(numero);
  ```

* Supprission:
  ```sql
  ALTER TABLE nom_table DROP FOREIGN KEY symbole_contrainte;
  ALTER TABLE Commande DROP FOREIGN KEY fk_client_numero;
  ```

### **_ON UPDATE_** & **_ON DELETE_**:

* Any `UPDATE` or `DELETE` on parent take effects on child.
* `RESTRICT` : Est le comportement par défaut, Si l'on essaye de supprimer une valeur référencée l'action est avortée, une erreur.
* `NO ACTION`: A exactement le meme effet que `RESTRICT`.
* `SET NULL` : `NULL` est substitué aux valeurs dont la référence est supprimé.

  ```sql
  mysql> ADD CONSTRAINT fk_race_id FOREIGN KEY(race_id) REFERENCES Race(id) ON DELETE SET NULL;
  ```

* `CASCADE` : Deleting a row in a table should also delete all related rows in the other table.
  ```sql
  mysql> ALTER TABLE Animal
  mysql> ADD CONSTRAINT fk_race_id FOREIGN KEY (race_id) REFERENCES Race(id)
  mysql> ON DELETE SET NULL
  mysql> ON UPDATE CASCADE;  

  -- Another example
  mysql> ALTER TABLE Commande ADD CONSTRAINT fk_client_numero 
  mysql> FOREIGN KEY (client) REFERENCES Client(numero)
  mysql> ON UPDATE CASCADE
  mysql> ON DELETE RESTRICT;
  ```
- **_PgSQL_**
  ```sql
  psql> CREATE TABLE registrations(
     ->     registration_id VARCHAR(10),
     ->     registration_date DATE,
     ->     licence_id VARCHAR(10) REFERENCES licenses(license_id) ON DELETE CASCADE,
     ->     CONSTRAINT registration_key PRIMARY KEY(registration_id, license_id)
     -> );
  ```

## Show Foreign key

```sql
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'table_name' AND CONSTRAINT_TYPE = 'FOREIGN KEY';
SHOW INDEXES FROM table_name;
```
* OR
  ```sql
  SELECT `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`,`REFERENCED_TABLE_SCHEMA`,`REFERENCED_TABLE_NAME`,`REFERENCED_COLUMN_NAME`
  FROM `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE` 
  WHERE `TABLE_SCHEMA` = SCHEMA() AND `REFERENCED_TABLE_NAME` IS NOT NULL;
  ```

## Drop tables ignoring FOREIGN KEY

```sql
mysql> SET FOREIGN_KEY_CHECKS = 0;
mysql> DROP TABLE IF EXISTS table_name;
mysql> SET FOREIGN_KEY_CHECKS = 1;
```

***
<a name='unique'/>

# <center>UNIQUE</center>

- Ensure that a column has a unique value in each row by using the **_UNIQUE_** constraint.
- **_UNIQUE_** constraint permits multiple **_NULL_** values in a column.

### Creation:

1. Index dans la description de la colonne:
  ```php
  mysql> CREATE TABLE nom_table (
      ->     colonne1 INT KEY,                  # Crée un index simple sur colonne1
      ->     colonne2 VARCHAR(40) UNIQUE,       # Crée un index UNIQUE sur colonne2
      -> );

  psql> CREATE TABLE unique_constraint_example(
     ->     contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
     ->     fname VARCHAR(50),
     ->     lname VARCHAR(50),
     ->     email VARCHAR(200),
     ->     CONSTRAINT email_unique UNIQUE(email)
     -> );
  ```

2. Ajouter les index à la suite des colonnes:
  ```sql
  CREATE TABLE Animal (
      id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
      espece VARCHAR(40) NOT NULL,
      date_naissance DATETIME NOT NULL,
      nom VARCHAR(30),
      PRIMARY KEY (id),
      INDEX ind_date_naissance (date_naissance),      # index sur la date de naissance
      INDEX ind_nom (nom(10)),                        # le chiffre entre parenthèses, le nombre de caractères pris en compte
      UNIQUE INDEX ind_uni_nom_espece (nom, espece)   # Index UNIQUE sur le nom et l'espece, INDEX est facultatif
  ) ENGINE=INNODB;
  ```

3. Adding Constraint Later
  ```sql
  mysql> ALTER TABLE nom_table ADD UNIQUE [nom_index] (colonne_index [, colonne2_index ...]); # Ajout d'un index UNIQUE
  mysql> ALTER TABLE Test_tuto ADD INDEX UNIQUE ind_nom (nom);   # Exemple avec la table test tuto
  mysql> CREATE UNIQUE INDEX ind_nom ON Test_tuto (nom);         # Crée un index UNIQUE
  ```

### Création d'un index `UNIQUE` - le cas des contraintes

```sql
mysql> CREATE TABLE nom_table (
    ->     colonne1 INT NOT NULL,
    ->     colonne2 VARCHAR(40),
    ->     colonne3 TEXT,
    ->     CONSTRAINT [symbole_contrainte] UNIQUE [INDEX] ind_uni_col2 (colonne2)
    -> );

mysql> ALTER TABLE nom_table
mysql> ADD CONSTRAINT [symbole_contrainte] UNIQUE ind_uni_col2 (colonne2);
```

* Il n'est pas obligatoire de donner un symbole (un nom en fait) à la contrainte.
* D'autant plus que dans le cas des index, vous pouvez donner un nom à l'index (ici : ind_uni_col).
   
### Suppression d'un index:

* Notez qu'il n'existe pas de commande permettant de modifier un index. 
* Le cas échéant, il vous faudra supprimer, puis recréer votre index avec vos modifications.

  ```sql
  ALTER TABLE nom_table DROP INDEX nom_index;
  ```

***

<a name="fulltext"/>

# <center>FULLTEXT</center>

### Creation Des index FULLTEXT:

* Les index 'par la gauche' ne sont pas pris en compte par les index `FULLTEXT`

  ```sql
  CREATE TABLE kjv
  (
   bsect ENUM('O','N') NOT NULL,    # book section (testament)
   bname VARCHAR(20) NOT NULL,      # book name
   bnum TINYINT UNSIGNED NOT NULL,  # book number
   cnum TINYINT UNSIGNED NOT NULL,  # chapter number
   vnum TINYINT UNSIGNED NOT NULL,  # verse number
   vtext TEXT NOT NULL,             # text of verse
   FULLTEXT (vtext)                 # full-text index
  ) ENGINE = MyISAM;                # can be InnoDB for MySQL 5.6+

  ```

* After Creation of table
  
  ```sql
  mysql> CREATE FULLTEXT INDEX ind_full_titre ON Livre (titre);
  mysql> CREATE FULLTEXT INDEX ind_full_aut ON Livre (auteur);
  mysql> CREATE FULLTEXT INDEX ind_full_titre_aut ON Livre (titre, auteur);

  -- La table Livre existe dans la base de donnée elevage.
  ```

### Using a Full-Text Search

* `FULLTEXT`: is designed for looking through large amounts of text and can search multiple columns simultaneously. 
* To use this capability, add a `FULLTEXT` index to your table, and then use the `MATCH` operator to look for strings in the indexed column or columns. 
* `FULLTEXT` indexing can be used with `MyISAM` tables (or, as of MySQL 5.6, `InnoDB` tables) for nonbinary string data types.
* To perform a search using the `FULLTEXT` index, use `MATCH()` to name the indexed column and `AGAINST()` to specify what text to look for. 
* For example, you might wonder, 'How many times does the name Hadoram occur?' To answer that question, search the `vtext`
column using this statement:

  ```sql
  mysql> SELECT COUNT(*) from kjv WHERE MATCH(vtext) AGAINST('Hadoram');
  
  mysql> SELECT bname, cnum, vnum LEFT(vtext, 65) AS vtext
      -> FROM kjv WHERE MATCH(vtext) AGAINST('Hadoram')\G
      
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('Abraham') AND bname = 'Hebrews';
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('Abraham') AND bname = 'Hebrews' AND cnum = 11;
  ```

* If you expect to use search criteria frequently that include other non-FULLTEXT columns, add regular indexes to those columns so that queries perform better

  ```sql
  mysql> ALTER TABLE kjv ADD INDEX (bnum), ADD INDEX (cnum), ADD INDEX (vnum); 
  ```

### Using a Full-Text Search with Short Words

```sql
mysql> SELECT COUNT(*) AS 'total verses',
    -> COUNT(IF(vtext LIKE '%God%',1,NULL)) AS 'verses containing "God"',
    -> COUNT(IF(vtext LIKE '%sin%',1,NULL)) AS 'verses containing "sin"'
    -> FROM kjv;
```
* By default, the `MyISAM` full-text indexing engine doesn't include words less than four characters long. 
The minimum word length is a configurable parameter; to change it, set the `ft_min_word_len` system variable.

  ```bash
  [mysqld]
  ft_min_word_len=3
  ```
* After making this change, restart the server. 
* Next, rebuild the `FULLTEXT` index to take advantage of the new setting:

  ```sql
  mysql> REPAIR TABLE kjv QUICK;
  ```
  
* Finally, try the new index to verify that it includes shorter words

  ```sql
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('God');
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('sin');
  ```
  
### Requiring or Prohibiting Full-Text Search Words

* following statement finds rows that contain either of the names David or Goliath
  ```sql
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('David Goliath');  -- Return 898
  ```

* This behavior is undesirable if you want only rows that contain both words.
  ```sql
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('David') AND MATCH(vtext) AGAINST('Goliath');  -- return 2
  ```
* An easier way to require multiple words is with a Boolean mode search.
* To do this, precede each word in the search string with a `+` character and add IN BOOLEAN MODE after the string:
* Boolean mode searches also permit you to exclude words by preceding each one with a `-` character.
  
  ```sql
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('+David +Goliath' IN BOOLEAN MODE);  -- Return 2
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('+David -Goliath' IN BOOLEAN MODE);  -- David but not Goliath
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('-David +Goliath' IN BOOLEAN MODE);
  
  SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('+bonheur -orges' IN BOOLEAN MODE);
  -- (+) devra être présent, (-) il ne pourra pas être présent.
  ```

* Another useful special character in Boolean searches is `*`, when appended to a search word, it acts as a wildcard operator.

  ```sql
  -- finds rows containing not only whirl, but also words such as whirls, whirleth, and whirlwind
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('whirl*' IN BOOLEAN MODE); 
  
  -- Titre et auteur commençant par \"d\".
  mysql> SELECT * FROM Livre WHERE MATCH(titre, auteur) AGAINST ('d*' IN BOOLEAN MODE); 
  
  -- Tous les mots commençant par \"petit\".
  SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('petit*' IN BOOLEAN MODE);      

  -- Mix d'un astérisque avec les + et -"
  SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('+petit* -prose' IN BOOLEAN MODE); 
  ```
  

###  Performing Full-Text Phrase Searches

* Instead, use full-text Boolean mode, which supports phrase searching. 
* Enclose the phrase in double quotes within the search string

  ```sql
  mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('"still small voice"' IN BOOLEAN MODE);
  
  mysql> SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('"Terre à la Lune"' IN BOOLEAN MODE);
  mysql> SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('"Lune à la Terre"' IN BOOLEAN MODE);
  mysql> SELECT * FROM Livre WHERE MATCH(titre) AGAINST ('"Terre la Lune"' IN BOOLEAN MODE);
  ```

* Recherche avec extension de requête:

  ```sql
  SELECT * FROM Livre WHERE MATCH(titre, auteur) AGAINST ('Daniel');      -- Simple recherche

  SELECT * FROM Livre WHERE MATCH(titre, auteur) AGAINST ('Daniel' WITH QUERY EXPANSION);

  -- "Le Bonheur est dans le crime" a donc été ajouté aux résultats, à cause de la présence du mot "bonheur" dans son titre 
  -- ("Bonheur" étant également présent dans "Au bonheur des ogres").
  ```

