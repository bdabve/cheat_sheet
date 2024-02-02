<link rel="stylesheet" href="style.css">

# <center>Tables</center>

## Table of Content

* [Information sur Table](#information-sur-table)
* [Suppression de Table](#suppression-de-table)
* [Cloning a Table](#cloning-a-table)
* [Creating Temporary Tables](#creating-temporary-tables)
* [Generating Unique Table Names](#generating-unique-table-names)
* [Renommer une Table](#renommer-une-table)
* [Modification des Tables](#modification-des-tables)
* [Truncate Command](#truncate-command)
* [Views](#views)

***

* [Linux Main](file:///home/dabve/web_dev/sql/mySql/linux_main.md)
* [Windows Main]()

## Creation de TABLES:

- MySQL

  ```sql
  mysql> CREATE TABLE Animal (
      ->    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,   -- UNSIGNED=valeur positive
      ->    espece VARCHAR(40) NOT NULL,
      ->    sexe CHAR(1),
      ->    date_naissance DATETIME NOT NULL,
      ->    nom VARCHAR(30),
      ->    commentaires TEXT,
      ->    PRIMARY KEY (id))                               -- Definire la cle primaire.
      -> ENGINE=INNODB;                                     -- Moteur de la table.
  ```

- PostgresSQL

    ```sql
    psql> CREATE TABLE departments(
       -> dept_id bigserial,                                  -- auto increment
       -> dept varchar(100),
       -> city varchar(100),
       -> CONSTRAINT dept_key PRIMARY KEY(dept_id),           -- primary key
       -> CONSTRAINT dept_city_unique UNIQUE(dept, city));

    psql> CREATE TABLE employees(
       -> emp_id bigserial,                                     -- auto increment
       -> first_name varchar(100),
       -> last_name varchar(100),
       -> salary integer,
       -> dept_id integer REFERENCES departments(dept_id),
       -> CONSTRAINT emp_key PRIMARY KEY(emp_id),               -- primary key
       -> CONSTRAINT emp_dept_unique UNIQUE(emp_id, dept_id));  -- UNIQUE index
    ```

[*Return to the Top*](#table-of-content)

## Information sur Table

- MySQL

  ```sql
  mysql> SHOW TABLES;                    -- Liste les table de la base de donnees.
  mysql> SHOW CREATE TABLE Animal;       -- Comment la table a ete creer.
  mysql> SHOW TABLE STATUS;              -- Status de la table.
  mysql> DESCRIBE Animal;                -- Liste les colonnes de la table avec leurs caracteristiques.
  ```

- PgSQL
  ```sql
  \d                      -- list tables
  \d table_name           -- describe a table name
  \d+ table_name          -- more informations
  ```

- SQLite
  ```sql
  sqlite> SELECT name, sql FROM sqlite_master WHERE type = 'table';
  ```

[*Return to the Top*](#table-of-content)

## Suppression de Table
    
```sql
mysql> DROP TABLE Animal;                                    -- Remove table 
mysql> DROP TABLE IF EXISTS tableName;
```

[*Return to the Top*](#table-of-content)

## Cloning a Table

* `CREATE TABLE … LIKE … `: To create a new table that is just like an existing table
* The structure of the new table is the same as that of the original table
* NOTE: Does not copy foreign key definitions, and it doesn't copy any DATA DIRECTORY or INDEX DIRECTORY 
  table options that the table might use.

  ```sql
  mysql> CREATE TABLE new_table LIKE original_table;

  --  To include indexes in the destination table, specify the explicitly.
  mysql> CREATE TABLE new_table (PRIMARY KEY (id), INDEX(state, city)) SELECT * FROM original_table WHERE FALSE;
  ```

* The new table is empty.
* If you also want the contents to be the same as the original table, copy the rows using an `INSERT` statement and `SELECT`.

  ```sql
  mysql> INSERT INTO new_table SELECT * FROM original_table;
  mysql> INSERT INTO new_table SELECT * FROM original_table WHERE name = 'barb';

  -- Copyt part of the table
  mysql> INSERT INTO new_table SELECT * FROM original_table WHERE size > 1000;
  mysql> INSERT INTO new_table(name, fullname) SELECT name, fullname FROM original_table;
  mysql> INSERT INTO new_table SELECT * FROM original_table WHERE size > 1000 AND name like 'A%';
  ```

* Alternatively, use `CREATE TABLE … SELECT` to create the distination table directly from the result of the `SELECT`

  ```sql
  mysql> CREATE TABLE new_table SELECT * FROM original_table
  ```

* To create an empty table, use `WHERE` clause that select no rows

  ```sql
  mysql> CREATE TABLE new_table SELECT * FROM original_table WHERE FALSE;
  ```

* To copy only some of the columns, name the ones you want in the `SELECT` part of the statement.

  ```sql
  mysql> CREATE TABLE new_table SELECT name, fullname FROM original_table WHERE FALSE;
  ```

* The following statement creates `id` and adds columns a, b, and c from `original_table`

  ```sql
  mysql> CREATE TABLE new_table (
      ->     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY) 
      ->     SELECT a, b, c FROM original_table WHERE FALSE;
  ```

* Generates a summary that lists each invoice named in the table and the total cost of its items, usint un alias for the expression

  ```sql
  mysql> CREATE TABLE new_table
      -> SELECT inv_no, SUM(unit_cost * quantity) AS total_cost FROM original_table GROUP BY inv_no;
  ```

[*Return to the Top*](#table-of-content)

## Creating Temporary Tables

* `CREATE TEMPORARY TABLE`
- This statements is like `CREATE TABLE` but creates a transient table that disappears when your session with the server ends.

  ```sql
  CREATE TEMPORARY TABLE tbl_name(... column definitions ...);
  CREATE TEMPORARY TABLE tbl_name LIKE original_table;
  CREATE TEMPORARY TABLE tbl_name SELECT … ;

  DROP TEMPORARY TABLE IF EXISTS tbl_name;
  ```

* A temporary table can have the same name as a permanent table.
* In this case, the temporary table 'hide' the permanent table for the duration of its existence.
* Attempting to create a second temporary table with the same name results in an error.

[*Return to the Top*](#table-of-content)

### Generating Unique Table Names

* If you cannot or do not want to use a `TEMPORARY` table, make sure that each invocation of the script creates a uniquely named table and drops the table when it is no longer needed.

* It's possible to incorporate a connection ID into a table name within SQL by using prepared statement.

  ```sql
  SET @table_name = CONCAT('tmp_table_', CONNECTION_ID());

  -- Droping Table First
  SET @stmt = CONCAT('DROP TABLE IF EXISTS ', @table_name); 
  PREPARE stmt FROM @stmt;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  -- Creating Table
  SET @stmt = CONCAT('CREATE TABLE ', @table_name, ' (i INT NOT NULL AUTO_INCREMENT PRIMARY KEY)'); 
  PREPARE stmt FROM @stmt;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  ```

[*Return to the Top*](#table-of-content)

## Renommer une TABLE:

```sql
mysql> RENAME TABLE Animal TO animals;                                 -- Rename one table.
mysql> RENAME TABLE Animal TO Animals, Category TO Categories;         -- Rename multiple tables.

mysql> ALTER TABLE table_name RENAME new_table_name;                   -- Rename Table
```

***

[*Return to the Top*](#table-of-content)

## Modification des Tables:

* La commande `ALTER TABLE` permet de modifier une table.
* Lorsque l'on ajoute ou modifie une colonne, il faut toujours préciser sa (nouvelle) description complète (type, valeur par défaut, auto-incrément éventuel)

* `ADD` and `DROP`: Permet d'ajouter ou retirer quelque chose (une colonne par exemple)
    
    ```sql
    mysql> ALTER TABLE Test_tuto ADD COLUMN date_insertion DATE NOT NULL;          -- At end of table
    mysql> ALTER TABLE Test_tuto ADD COLUMN date_naissance DATE NOT NULL FIRST;    -- At beginning of table
    mysql> ALTER TABLE Contact ADD COLUMN user_name VARCHAR(255) AFTER name;       -- Specify where to add.
    
    mysql> ALTER TABLE Test_tuto DROP COLUMN date_insertion;
    ```
    
* `CHANGE`: Changer quelque chose qui exist, La description de la colonne doit être complète
    
    ```sql
    mysql> ALTER TABLE Test_tuto CHANGE nom prenom VARCHAR(10) NOT NULL;     -- Renommer nom a prenom 
    mysql> ALTER TABLE Test_tuto CHANGE prenom nom VARCHAR(30) NOT NULL;     -- Changement du type + nom
    mysql> ALTER TABLE Test_tuto CHANGE id id BIGINT NOT NULL;               -- Changement du type sans renommer
    mysql> ALTER TABLE contacts CHANGE user user VARCHAR(255) AFTER name;    -- Changement de place.
    ```

* `MODIFY`: Permettent de modifier une colonne.
    
    ```sql
    mysql> ALTER TABLE Test_tuto MODIFY id BIGINT NOT NULL AUTO_INCREMENT;     -- Ajout de l'auto-incrémentation
    -- Changement de la description (même type mais ajout valeur par défaut)
    mysql> ALTER TABLE Test_tuto MODIFY nom VARCHAR(30) NOT NULL DEFAULT 'Blabla';
    ```

* Diverse:
    
    ```sql
    mysql> ALTER TABLE tbl_name CONVERT TO CHARACTER SET charset_name;                     -- Change character
    mysql> ALTER TABLE tbl_name CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
    mysql> ALTER TABLE etape_prospection CHARSET=utf8;
        
    mysql> ALTER TABLE contacts MODIFY password VARCHAR(255), CHANGE id user_id SMALLINT(5);
    ```

[*Return to the Top*](#table-of-content)

### Truncate Command

* La commande `TRUNCATE nom_table;`, a le même effet que `DELETE FROM nom_table;` (sans clause WHERE), elle supprime toutes les lignes de la table. 
* Cependant, `TRUNCATE` est un peu différent de `DELETE FROM`.
* `TRUNCATE` ne supprime pas les lignes une à une: `TRUNCATE` supprime la table, puis la recrée (sans les données).
* Par conséquent, `TRUNCATE` ne traite pas les clés étrangères: on ne peut pas faire un `TRUNCATE`  sur une table dont une colonne est référencée par une clé étrangère, sauf si celle-ci est dans la même table. 
* En outre, les options `ON DELETE` ne sont pas traitées lorsque des données sont supprimées avec cette commande.
* `TRUNCATE` valide implicitement les transactions, et ne peut pas être annulé par un rollback.
* Pour toutes ces raisons, `TRUNCATE` est beaucoup plus rapide que `DELETE FROM` (en particulier si le nombre de lignes à supprimer est important).

[*Return to the Top*](#table-of-content)

***

### Views

- View is a virtual table that contains no data. 
- Instead, it's defined as the SELECT statement that retrieves the data of interest.

  ```sql
  -- Suppose that you issue such a statement often
  mysql> SELECT DATE_FORMAT(t,'%M %e, %Y') AS date_sent, CONCAT(srcuser,'@',srchost) AS sender, 
      -> CONCAT(dstuser,'@',dsthost) AS recipient, size FROM mail;

  --  Creating the view
  mysql> CREATE VIEW mail_view AS
      -> SELECT DATE_FORMAT(t,'%M %e, %Y') AS date_sent, CONCAT(srcuser,'@',srchost) AS sender, 
      -> CONCAT(dstuser,'@',dsthost) AS recipient, size FROM mail;

  -- Work with the view
  mysql> SELECT date_sent, sender, size FROM mail_view WHERE size > 100000 ORDER BY size;
  ```

[*Return to the Top*](#table-of-content)
