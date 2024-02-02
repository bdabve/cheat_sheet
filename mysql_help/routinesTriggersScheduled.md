<title>Routines, Triggers, Scheduled Events</title>

## <center>Using Stored Routines, Triggers, and Scheduled Events</center>

### Table of Contents

* [IF ELSE and SWITCH](#ifThen)
* [Loops](#loops)
* [Functions](#functions)
* [Procedures](#procedures)
* [Triggers](#triggers)
* [Events](#events)
* [Prepared Statements](#preparedStmt)


### User-Defined Variable in SQL Statement

* This enables you to refer to it in other statement later in the same session but not across sessions.
* User variable are a MySQL-specific extension to standard SQL. They will not work with other database engines.
* Syntax: `@var_name := value`, and for Calling: `@var_name`
* The variable can be used in subsequent statement, Such as in a `WHERE` or `INSERT`

  ```sql
  mysql> SELECT @max_age := MAX(age) FROM cats;
  mysql> SELECT * FROM cats WHERE age = @max_age;

  mysql> SELECT @last_id := LAST_INSERT_ID();
  mysql> SELECT * FROM cats WHERE id = @last_id;
  ```

* To set a variable explicitly to a paricular value, use a `SET` statement.
* Syntax: `@var_name := value` OR `@var_name = value` 

  ```sql
  mysql> SET @sum = 4+7;
  mysql> SELECT @sum;

  SET @salut = 'Hello World !', @poids = 7.8, @age=18;     -- On peut créer plusieurs variables en même temps
  SELECT @age, @poids, @salut;

  mysql> SET @max_age = (SELECT MAX(age) FROM cats);
  mysql> SELECT @max_age;

  mysql> SET @conversionDollar = 1.31564;      -- On crée une variable contenant le taux de conversion des euros en dollars
      -> SELECT prix AS prix_en_euros,         -- On sélectionne le prix des races, en euros et en dollars.
      -> ROUND(prix * @conversionDollar, 2) AS prix_en_dollars,   -- En arrondissant à deux décimales
      -> nom FROM Race;
  ```

### Introduction

* Stored programs are database objects that are user-defined but stored on the server side for later execution. 
* This differs from sending an SQL statement from the client to the server for immediate execution. 
* Each object also has the property that it is defined in terms of other SQL statements to be executed when the object is invoked. 
* The object body is a single SQL statement, but that statement can use compound-statement syntax (a `BEGIN...END` block) that contains multiple statements. Thus, the body can range from very simple to extremely complex. 
* The following stored procedure is a trivial routine that does nothing but display the current MySQL version, using a body that consists of a single `SELECT` statement:

  ```sql
  mysql> CREATE PROCEDURE show_version() 
      -> SELECT VERSION AS 'MySQL Version';
  ```

* More complex operations use a BEGIN...END compound statement

  ```sql
  mysql> CREATE PROCEDURE show_part_of_day()
      -> BEGIN
      ->  DECLARE cur_time, day_part TEXT;      // Declaring local variable
      ->  SET cur_time = CURTIME();
      ->  IF cur_time < '12:00:00' THEN
      ->    SET day_part = 'morning';
      ->  ELSEIF cur_time = '12:00:00' THEN
      ->    SET day_part = 'noon';
      ->  ELSE
      ->    SET day_part = 'Afternoon or night';
      ->  END IF;
      ->  SELECT cur_time, day_part;
      -> END;
  ```

* Compound statements enable you to declare local variables and to use conditional logic and looping constructs. 
* These capabilities provide considerably more flexibility for algorithmic expression than when you write inline expressions in noncompound statements such as `SELECT` or `UPDATE` .
* Use the delimiter command to change the mysql delimiter, then restore the delimiter to its default value

  ```sql
  mysql> delimiter $$
  mysql> delimiter ;;
  ```

* Example

  ```sql
  mysql> CREATE FUNCTION avg_mail_size(user VARCHAR(8))
      -> RETURNS FLOAT READS SQL DATA   -- Indicates the type of the function's return value, 
      -- READS SQL DATA indicates that the functions reads but does not modify data
      -> BEGIN
      ->    DECLARE avg FLOAT;
      ->    IF user IS NULL THEN               -- Average message size over all users
      ->        SET avg = (SELECT AVG(size) FROM mail);
      ->    ELSE                                -- Average message size for given suer
      ->        SET avg = (SELECT AVG(size) FROM mail WHERE srcuser = user);
      ->    END IF;
      ->    RETURN avg;
      -> END $$

  -- After defining the stored function, invoke it the same way
  mysql> SELECT avg_mail_size(NULL), avg_mail_size('barb');
      -> 237386.5625 | 52232
  ```

***
<a name="ifThen"/>

## <center>IF ELSE, SWITCH</center>

* `IF ELSE END IF`

  ```sql
  -- Another Example
  mysql> CREATE PROCEDURE adopté(IN p_animal_id INT)
      -> BEGIN
      ->   DECLARE v_nb INT DEFAULT 0;                                              -- Local variable
      ->   SELECT COUNT(*) INTO v_nb FROM Adoption WHERE animal_id = p_animal_id;   -- Counting number of ligne and set it to our variable
      ->   IF v_nb > 0 THEN   -- Conditional test
      ->     SELECT 'J''ai déjâ été adopté !';
      ->   END IF;                                                                  -- D'ont forget END IF and ;
      -> END$$
      
  mysql> CALL adopté(5)$$
      -> J'ai déjâ été adopté !

  mysql> CREATE PROCEDURE avant_apres_2010(IN p_animal_id INT)
      -> BEGIN
      ->   DECLARE v_annee INT;
      ->   SELECT YEAR(date_naissance) INTO v_annee FROM Animal WHERE id = p_animal_id;
      ->   IF v_annee < 2010 THEN
      ->       SELECT 'Je suis né avant 2010' AS naissance;
      ->   ELSE     -- Pas de THEN
      ->       SELECT 'Je suis né aprés 2010' AS naissance;
      ->   END IF; 
      -> END$$ 

  mysql> CREATE PROCEDURE message_sexe(IN p_animal_id INT)
      -> BEGIN
      ->   DECLARE v_sexe VARCHAR(10);
      ->   SELECT sexe INTO v_sexe FROM Animal WHERE id = p_animal_id;
      ->   IF (v_sexe = 'F') THEN  SELECT 'Je suis une femelle' AS sexe;
      ->   ELSE IF (v_sexe = 'M') THEN SELECT 'Je suis un male' AS sexe;
      ->   ELSE SELECT 'Je sais pas' AS sexe;
      ->   END IF;
      -> END$$
  ```

* `CASE`

  ```sql
  mysql> CREATE PROCEDURE message_sexe(IN p_animal_id INT)
      -> BEGIN
      ->   DECLARE v_sexe VARCHAR(10);
      ->   SELECT sexe INTO v_sexe FROM Animal WHERE id = p_animal_id;
      ->   CASE v_sexe
      ->     WHEN 'F' THEN
      ->       SELECT 'Je suis une femelle !' AS sexe;
      ->     WHEN 'M' THEN
      ->       SELECT 'Je suis un male !' AS sexe;
      ->     ELSE 
      ->       SELECT 'Je suis en plain quistionnement existantiel...!' AS sexe;
      ->     END CASE;
      -> END$$

  -- Un autre example avec OUT
  mysql> CREATE PROCEDURE avant_apres_2010_case(IN p_animal_id INT, OUT p_message VARCHAR(100))
      -> BEGIN
      ->   DECLARE v_annee INT;
      ->   SELECT YEAR(date_naissance) INTO v_annee FROM Animal WHERE id = p_animal_id;
      ->   CASE
      ->     WHEN v_annee < 2010 THEN SET p_message = 'Je suis né avant 2010.';
      ->     WHEN v_annee = 2010 THEN SET p_message = 'Je suis né en 2010';
      ->     ELSE SET p_message = 'Je suis né aprés 2010.';
      ->   END CASE;
      -> END$$
  ```

* Structure conditionnelle directement dans une requête

  ```sql
  mysql> SELECT id, nom, CASE
      ->   WHEN sexe = 'M' THEN 'Je suis un male !'
      ->   WHEN sexe = 'F' THEN 'Je suis une femelle!'
      ->   ELSE 'Je suis en plein quistionnement existentiel...'
      ->   END AS message
      -> FROM Animal WHERE id IN (9, 8, 6);
  ```

* `IF(condition, valeur_si_vrai, valeur_si_faux)` function

  ```sql
  mysql> SELECT nom, IF(sexe = 'M', 'Je suis un male', 'Je ne suis pas un male') AS sexe FROM Animal WHERE id IN (6, 8, 9);
  ```

***
<a name="loops"/>

## <center>Loops</center>

* `WHILE`

  ```sql
  mysql> CREATE PROCEDURE compter_jusque_while(IN p_nombre INT)
      -> BEGIN
      ->   DECLARE v_i INT DEFAULT 1;
      ->   WHILE v_i <= p_nombre DO
      ->     SELECT v_i AS nombre;
      ->     SET v_i = v_i + 1;
      ->   END WHILE;
      -> END$$
  ```

* `REPEAT`

  ```sql
  mysql> CREATE PROCEDURE compter_jusque_repeat(IN p_nombre INT)
      -> BEGIN
      ->   DECLARE v_i INT DEFAULT 1;
      ->   REPEAT
      ->     SELECT v_i AS nombre;
      ->     SET v_i = v_i + 1;
      ->   UNTIL v_i > p_nombre END REPEAT;
      -> END$$
  ```

* Il est possible de donner un label(un nom) a une bouce ou a un block d'instuction
  ```sql
  super_while: WHILE condition DO       -- nom : 
    instruction
  END WHILE super_while;

  block_extra: BEGIN
    instruction
  END block_extra;
  ```
* `LEAVE`, `ITERATE`: Like `break` and `continue` in other languages like python or php

  ```sql
  DELIMITER |
  CREATE PROCEDURE test_leave1(IN p_nombre INT)
  BEGIN
      DECLARE v_i INT DEFAULT 4;
      SELECT 'Avant la boucle WHILE';
      while1: WHILE v_i > 0 DO
          SET p_nombre = p_nombre + 1 -- On incrémente le nombre de 1
          IF p_nombre%10 = 0 THEN     -- Si p_nombre est divisible par 10,
              SELECT 'Stop !' AS 'Multiple de 10';
              LEAVE while1;   -- On quitte la boucle WHILE.
          END IF;
          SELECT p_nombre;    -- On affiche p_nombre
          SET v_i = v_i - 1;  -- Attention de ne pas l'oublier
      END WHILE while1;
      SELECT 'Après la boucle WHILE';
  END$$

  CALL test_leave1(3); -- La boucle s'exécutera 4 fois
  ```

* `LOOP`

  ```sql
  DELIMITER |
  CREATE PROCEDURE compter_jusque_loop(IN p_nombre INT)
  BEGIN
      DECLARE v_i INT DEFAULT 1;

      boucle_loop: LOOP
          SELECT v_i AS nombre; 

          SET v_i = v_i + 1;

          IF v_i > p_nombre THEN
              LEAVE boucle_loop;
          END IF;    
      END LOOP;
  END |
  DELIMITER ;

  CALL compter_jusque_loop(3);
  ```

*** 
<a name="functions"/>

## <center>Functions</center>

* You must have the **_SUPER_** privilege, and you must declare either that the function is deterministic or does not modify data by using one of the **_DETERMINISTIC_**, **_NO SQL_** , or **_READS SQL DATA_** characteristics. (It’s possible to create functions that are not deterministic or that modify data, but they might not be safe for replication or for use in backups.)

- Beggining by a simple function than retern like **_string.title()_** in python.
  ```sql
  mysql> CREATE FUNCTION initial_cap(s VARCHAR(255))
      -> RETURNS VARCHAR(255) DETERMINISTIC
      -> RETURN CONCAT(UPPER(LEFT(s,1)), MID(s, 2));

  -- Call the function.
  mysql> SELECT thing, initial_cap(thing) FROM limbs;
  ```
-

  ```sql
  mysql> delimiter $$
  mysql> CREATE FUNCTION sales_tax_rate(state_code CHAR(2))
      -> RETURNS DECIMAL(3,2) READS SQL DATA -- handles states not listed using a CONTINUE handler for NOT FOUND
      -> BEGIN
      ->    DECLARE rate DECIMAL(3,2);
      ->    DECLARE CONTINUE HANDLER FOR NOT FOUND SET rate = 0;
      ->    SELECT tax_rate INTO rate FROM sales_tax_rate WHERE state = state_code;
      ->    RETURN rate;
      -> END;
  mysql> delimiter ;
  
  mysql> SELECT sales_tax_rate('AR'), sales_tax_rate('AL');
      ->  0.06 | 0.03
  mysql> mysql> SELECT sales_tax_rate('ZZ');    -- ZZ Not listed in the table
      -> 0.00
      
  -- To compute sales tax for a purchase, multiply the purchase price by the tax rate.
  mysql> SELECT 150*sales_tax_rate('VT'), 150*sales_tax_rate('NY');
      -> 1.50 | 13.50
  ```

* Or write another function that computes the tax for you

  ```sql
  mysql> CREATE FUNCTION sales_tax(state_code CHAR(2), sales_amount DECIMAL(10,2))
      -> RETURNS DECIMAL(10,2) READS SQL DATA
      -> RETURN sales_amount * sales_tax_rate(state_code);
      
  mysql> SELECT sales_tax('VT',150), sales_tax('NY',150);
      -> 1.50 | 13.50
  ```

***
<a name="procedures"/>

## <center>Procedures</center>

### Using Stored Procedures to “Return” Multiple Values

* A stored procedure performs operations for which no return value is needed. 
* Procedures are invoked with the `CALL` statement, not used in expressions. 
* A procedure might update rows in a table or produce a result set that is sent to the client program.

* Unlike stored function parameters, which are input values only, a stored procedure parameter can be any of three types:
  * An `IN` parameter is for input only. This is the default if you specify no type.
  * An `INOUT` parameter is used to pass a value in, and can also pass a value out.
  * An `OUT` parameter is used to pass a value out.

* Thus, to produce multiple values from an operation, you can use `INOUT` or `OUT` parameters.

  ```sql
  mysql> CREATE PROCEDURE mail_sender_stats(IN user VARCHAR(8), OUT messages INT, OUT total_size INT, OUT avg_size INT)
      -> BEGIN
      ->    SELECT COUNT(*), IFNULL(SUM(size), 0), IFNULL(AVG(size), 0)
      ->    INTO messages, total_size, avg_size FROM mail WHERE srcuser = user;
      -> END $$
  mysql> CALL mail_sender_stats('barb', @messages, @total_size, @avg_size);
  mysql> SELECT @messages, @total_size, @avg_size;

  mysql> CREATE PROCEDURE compter_race_selon_espece(p_espece_id INT, OUT p_nb_races INT)
      -> BEGIN
      ->    SELECT COUNT(*) INTO p_in_races FROM Race WHERE espece_id = p_espece_id;
      -> END $$
  mysql> CALL compter_race_selon_espece(2, @nb_chat);
  mysql> SELECT @nb_chat;

  -- Another example of SELECT INTO
  mysql> SELECT id, nom INTO @var1, @var2 FROM Animal WHERE id = 7$$
  mysql> SELECT @var1, @var2;
  ```

### Procedure Status

```sql
mysql> SHOW PROCEDURE STATUS;
mysql> SHOW PROCEDURE STATUS WHERE db = 'db_name';
mysql> SHOW PROCEDURE STATUS name LIKE '%product%';
mysql> SHOW CREATE PROCEDURE name_of_procedure;
```

*** 
<a name="triggers"/>

## <center>Using Triggers</center>

### Using Triggers to Implement Dynamic Default Column Values

* A trigger is an object that activates when a table is modified by an `INSERT`, `UPDATE`, or `DELETE` statement.

* You cannot define a column with a `DEFAULT` clause that refers to a function call or other arbitrary expression, and you cannot define one column in terms of the value assigned to another column. 
* That means each of these column definitions is illegal:
  
  ```sql
  d DATE DEFAULT NOW()
  i INT DEFAULT (... some subquery ...)
  hash_val CHAR(32) DEFAULT MD5(blob_col)
  ```

* You can work around this limitation by setting up a suitable trigger, which enables you to initialize a column however you want. 

* `BEFORE INSERT`: Which enables column values to be set before they are inserted into the table.
* `AFTER INSERT`: Can examine column values for a new row, but by the time the trigger activates, it’s too late to change the values.

* Suppose that you anticipate a need to know at some later date the tax rate from the time of sale.
  ```sql
  CREATE TABLE cust_invoice
  (
   id INT NOT NULL AUTO_INCREMENT,
   state CHAR(2),             # customer state of residence
   amount DECIMAL(10,2),      # sale amount
   tax_rate DECIMAL(3,2)      # sales tax rate at time of purchase
   PRIMARY KEY (id)
  );
  ```

* To initialize the sales tax column for inserts into the cust_invoice table, use a `BEFORE INSERT` trigger that looks up the rate and stores it in the table

  ```sql
  mysql> CREATE TRIGGER bi_cust_invoice BEFORE INSERT ON cust_invoice
      -> FOR EACH ROW SET NEW.tax_rate = sales_tax_rate(NEW.state);

  mysql> INSERT INTO cust_invoice (state,amount) VALUES('NY',100);
  mysql> SELECT * FROM cust_invoice WHERE id = LAST_INSERT_ID();
  ```
  
  * `NEW.col_name` refers to the new value to be inserted into the given column. 
  * By assigning a value to `NEW.col_name` within the trigger, you cause the column to have that value in the new row

* Openclassrooms exemple

  ```sql
  mysql> CREATE TRIGGER before_insert_animal BEFORE INSERT ON Animal
      -> FOR EACH ROW
      -> BEGIN
      ->   IF NEW.sexe IS NOT NULL AND NEW.sexe != 'M' AND NEW.sexe != 'F' THEN
      ->     SET NEW.sexe = NULL;
      ->   END IF;
      -> END$$

  mysql> CREATE TRIGGER before_update_animal BEFORE UPDATE ON Animal 
      -> FOR EACH ROW
      -> BEGIN
      ->   IF NEW.sexe IS NOT NULL AND NEW.sexe != 'M' AND NEW.sexe != 'F' THEN
      ->     SET NEW.sexe = NULL;
      ->   END IF;
      -> END$$
  ```

### Simulating TIMESTAMP Properties for Other Date and Time Types

* One way to simulate `TIMESTAMP` properties for other temporal data types is to use the following strategy:
  * When you create a row, initialize a `DATE` column to the current date and a `TIME` column to the current time.
  * When you update a row, set the `DATE` and `TIME` columns to the new date and time.
  
  ```sql
  mysql> CREATE TABLE ts_emulate (data CHAR(10), d DATE, t TIME);
  
  -- On Insert
  mysql> CREATE TRIGGER bi_ts_emulate BEFORE INSERT ON ts_emulate
      -> FOR EACH ROW SET NEW.d = CURDATE(), NEW.t = CURTIME();
  -- On update
  mysql> CREATE TRIGGER bu_ts_emulate BEFORE UPDATE ON ts_emulate
      -> FOR EACH ROW                     -- update temporal columns only if nontemporal column changes
      -> IF NEW.data <> OLD.data THEN     -- Check if new data != old data
      ->   SET NEW.d = CURDATE(), NEW.t = CURTIME();
      -> END IF;
  ```

### Using Triggers to Log Changes to a Table

* Use triggers to 'catch' table changes and write them to a separate log table.
* Suppose that you conduct online auctions, and that you maintain information about each currently active auction in a table that looks like this:

  ```sql
  mysql> CREATE TABLE auction
      -> (
      -> id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
      -> ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      -> item VARCHAR (30) NOT NULL,
      -> bid DECIMAL(10,2) NOT NULL
      -> );
  ```

* To maintain a journal that shows all changes to auctions as they progress from creation to removal, set up another table that serves to record a history of changes to the auctions.
* This strategy can be implemented with triggers

  ```sql
  mysql> CREATE TABLE auction_log
      -> (
      -> action ENUM('Create', 'Update', 'Delete'),
      -> id INT UNSIGNED NOT NULL,
      -> ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      -> item VARCHAR(30) NOT NULL,
      -> bid DECIMAL(10,2) NOT NULL,
      -> INDEX (id)
      -> );
  ```

  * The auction_log table differs from the auction table in two ways:
    * It contains an action column to indicate for each row what kind of change was made.
    * The id column has a nonunique index (rather than a primary key, which requires unique values). 
    * This permits multiple rows per id value because a given auction can generate many rows in the log table.

* To ensure that changes to the auction table are logged to the auction_log table, create a set of triggers. The triggers write information to the auction_log table as follows:
  * For inserts, log a row-creation operation showing the values in the new row.
  * For updates, log a row-update operation showing the new values in the updated row.
  * For deletes, log a row-removal operation showing the values in the deleted row.

  ```sql
  CREATE TRIGGER ai_auction AFTER INSERT ON auction
  FOR EACH ROW
  INSERT INTO auction_log (action,id,ts,item,bid)
  VALUES('create',NEW.id,NOW(),NEW.item,NEW.bid);

  CREATE TRIGGER au_auction AFTER UPDATE ON auction
  FOR EACH ROW
  INSERT INTO auction_log (action,id,ts,item,bid)
  VALUES('update',NEW.id,NOW(),NEW.item,NEW.bid);

  CREATE TRIGGER ad_auction AFTER DELETE ON auction
  FOR EACH ROW
  INSERT INTO auction_log (action,id,ts,item,bid)
  VALUES('delete',OLD.id,OLD.ts,OLD.item,OLD.bid);
  ```

* The `INSERT` and `UPDATE` triggers use `NEW.col_name` to access the new values being stored in rows. 
* The `DELETE` trigger uses `OLD.col_name` to access the existing values from the deleted row. 
* The `INSERT` and UPDATE triggers use `NOW()` to get the row-modification times; the ts column is initialized automatically to the current date and time, but `NEW.ts` will not contain that value.

  ```sql
  mysql> INSERT INTO auction (item,bid) VALUES('chintz pillows',5.00);
  mysql> UPDATE auction SET bid = 7.50 WHERE id = 792;
  ... time passes ...
  mysql> UPDATE auction SET bid = 9.00 WHERE id = 792;
  ... time passes ...
  mysql> UPDATE auction SET bid = 10.00 WHERE id = 792;
  ... time passes ...
  mysql> DELETE FROM auction WHERE id = 792;

  mysql> SELECT * FROM auction_log WHERE id = 792 ORDER BY ts;
  ```

***
<a name="events"/>

## <center>Events</center>

### Using Events to Schedule Database Actions

* An event is an object that executes SQL statements at a scheduled time or times.
* Think of a scheduled event as something like a Unix cron job that runs within MySQL.

* MySQL provides an event scheduler that enables you to set up database operations that run at times that you define. 

  ```sql
  mysql> CREATE TABLE mark_log
      -> (
      -> ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      -> message VARCHAR(100)
      -> );
  ```
* Our logging event will write a string to a new row. To set it up, use a `CREATE EVENT` statement:
* The mark_insert event causes the message '-- MARK --' to be logged to the mark_log table every five minutes.
* For an event body that executes multiple statements, use BEGIN … END compound-statement syntax.

  ```sql
  mysql> CREATE EVENT mark_insert ON SCHEDULE EVERY 5 MINUTE DO INSERT INTO mark_log(message) VALUES('--MARK--');
  ```

* The event scheduler isn’t running, which is its default state until you enable it. 
* Check the scheduler status by examining the value of the `event_scheduler` system variable
*
  ```sql
  mysql> SHOW VARIABLES LIKE 'event_scheduler';
  +-----------------+-------+
  | Variable_name   | Value |
  +-----------------+-------+
  | event_scheduler | OFF   |
  +-----------------+-------+
  ```
* To enable the scheduler interactively if it’s not running

  ```sql
  mysql> SET GLOBAL event_scheduler = 1;

  -- If you don't have privileges execute this statement as root
  mysql> GRANT SUPER ON *.* TO user@'localhost' IDENTIFIED BY 'password';
  mysql> FLUSH PRIVILEGES;
  ```

* To start the scheduler each time the server starts, enable the system variable in your my.cnf option file:

  ```bash
  [mysqld]
  event_scheduler=1
  ```

* Drop the event, Disable event execution, Reactivate it

  ```sql
  mysql> DROP EVENT mark_insert;
  mysql> ALTER EVENT mark_insert DISABLE;
  mysql> ALTER EVENT mark_insert ENABLE;
  ```

* Let the event continue to run, but set up another event that “expires” old mark_log rows. 
* This second event need not run so frequently (perhaps once a day). Its body should remove rows older than a given threshold.

  ```sql
  mysql> CREATE EVENT mark_expire
      -> ON SCHEDULE EVERY 1 DAY
      -> DO DELETE FROM mark_log WHERE ts < NOW() - INTERVAL 2 DAY;
  ```

***
<a name="preparedStmt"/>

## <center>Prepared Statement</center>

### Writing Helper Routines for Executing Dynamic SQL

* Using a prepared SQL statement involves three steps: 
  * `preparation`
  * `execution`
  * `deallocation`.

  ```sql
  SET @tbl_name = 'tbl_name';
  SET @stmt = CONCAT('CREATE TABLE ',@tbl_name,' (i INT)');
  PREPARE stmt FROM @stmt;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  SET @val = 12;
  SET @stmt = CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')');
  PREPARE stmt FROM @stmt;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  ```

* To ease the burden of going through those steps for each dynamically created statement, use a helper routine that, given a statement string, prepares, executes, and deallocates it:

  ```sql
  CREATE PROCEDURE exec_stmt(stmt_str TEXT)
  BEGIN
   SET @_stmt_str = stmt_str;
   PREPARE stmt FROM @_stmt_str;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
  END;

  -- The exec_stmt() routine enables the same statements to be executed much more simply:
  CALL exec_stmt(CONCAT('CREATE TABLE ',@tbl_name,' (i INT)'));
  CALL exec_stmt(CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')'));
  ```
* Now, how about making it safer to construct statement strings that incorporate values that might come from external sources.
* The `QUOTE()` function is available for quoting data values.
* There is no corresponding function for identifiers, but it’s easy to write one that doubles internal backticks and adds a backtick at the beginning and end:

  ```sql
  mysql> CREATE FUNCTION quote_identifier(id TEXT)
      -> RETURNS TEXT DETERMINISTIC 
      -> RETURN CONCAT('`', REPLACE(id, '`', '``'), '`');
  ```

* Revising the preceding example

  ```sql
  SET @tbl_name = quote_identifier(@tbl_name);
  SET @val = QUOTE(@val);
  CALL exec_stmt(CONCAT('CREATE TABLE ',@tbl_name,' (i INT)'));
  CALL exec_stmt(CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')'));
  ```

