<center>Transactions</center>

## Introduction

* The MySQL server can handle multiple clients at the same time because it is multi-threaded. 
* To deal with contention among clients, the server performs any necessary locking so that two clients cannot modify the same data at once. 
* To prevent concurrency and integrity problems in these types of situations, transactions are helpful. 
* A transaction groups a set of statements and guarantees the following properties:
  * No other client can update the data used in the transaction while the transaction is in progress; it’s as though you have the server all to yourself. Transactions solve concurrency problems arising from the multiple-client nature of the MySQL server. In effect, transactions serialize access to a shared resource across multiple-statement operations.
  * Statements grouped within a transaction are committed (take effect) as a unit, but only if they all succeed. If an error occurs, any actions that occurred prior to the error are rolled back, leaving the relevant tables unaffected as though none of the statements had been executed.

## Choosing a Transactional Storage Engine

* To use transactions, you must use a transaction-safe engine. Currently, the transactional engines include `InnoDB` and `NDB`.
* `MyISAM`: Does not support transactions.

  ```sql
  mysql> SELECT ENGINE FROM INFORMATION_SCHEMA.ENGINES
      -> WHERE SUPPORT IN ('YES','DEFAULT') AND TRANSACTIONS='YES';
  ```

## Performing Transactions Using SQL

* To perform a transaction, you must disable auto-commit mode, execute the statements that make up the transaction, and then either commit or roll back your changes. 
* In MySQL, you can do this two ways:


1. Execute a `START TRANSACTION` (or `BEGIN`) statement to suspend auto-commit mode, then execute the statements that make up the transaction. 
  * If the statements succeed, record their effect in the database and terminate the transaction by executing a `COMMIT` statement
  
    ```sql
    mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
    mysql> START TRANSACTION;
    mysql> INSERT INTO t (i) VALUES(1);
    mysql> INSERT INTO t (i) VALUES(2);
    mysql> COMMIT;
    mysql> SELECT * FROM t;
    ```

  * If an error occurs, don’t use `COMMIT`. Instead, cancel the transaction by executing a `ROLLBACK` statement. 
  
    ```sql
    mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
    mysql> START TRANSACTION;
    mysql> INSERT INTO t (i) VALUES(1);
    mysql> INSERT INTO t (x) VALUES(2);
    ERROR 1054 (42S22): Unknown column 'x' in 'field list'

    mysql> ROLLBACK;

    mysql> SELECT * FROM t;
    Empty set (0.00 sec) 
    ``` 

2. Another way to group statements is to turn off auto-commit mode explicitly by setting the autocommit session variable to `0`. After that, each statement you execute becomes part of the current transaction. 

  * To end the transaction and begin the next one, execute a `COMMIT` or `ROLLBACK` statement:
  
  ```sql
  mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
  mysql> SET autocommit = 0;            -- To turn off auto-commit
  mysql> INSERT INTO t (i) VALUES(1);
  mysql> INSERT INTO t (i) VALUES(2);
  mysql> COMMIT;
  mysql> SELECT * FROM t;
  +------+
  | i    |
  +------+
  | 1    |
  | 2    |
  +------+ 

  mysql> INSERT INTO t(i) VALUES(4), (5);
  +------+
  | i    |
  +------+
  |    1 |
  |    2 |
  |    4 |
  |    5 |
  +------+
  mysql> ROLLBACK; 
  mysql> SELECT * FROM t;
  +------+
  | i    |
  +------+
  |    1 |
  |    2 |
  +------+

  mysql> SET autocommit = 1;        -- To turn auto-commit mode back on
  ```

### Jalon de transaction

* Il n'est pas possible de démarrer une transaction a l'intérieur d'une transaction.
* Par contre, on peut poser des jalons de transaction.
* Il s'agit de points de repère qui permettent d'annuler toutes les requetes executées depuis ce jalon, et non toutes les requettes de la transaction

  ```sql
  START TRANSACTION;

  INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
  VALUES ('Popi', 5, '2007-03-11 12:45:00', 'M');

  SAVEPOINT jalon1;

  INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
  VALUES ('Momo', 5, '2007-03-12 05:23:00', 'M');

  ROLLBACK TO SAVEPOINT jalon1;

  INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
  VALUES ('Mimi', 5, '2007-03-12 22:03:00', 'F');

  COMMIT;
  ```

## Using Transactions in PHP Programs

* The `PDO` extension supports a transaction abstraction that can be used to perform transactions. 
* To begin a transaction, use the `beginTransaction()` method. 
* Then, after executing your statements, invoke either `commit()` or `rollback()` to commit or roll back the transaction. 

  ```php
  try
  {
     $dbh->beginTransaction ();
     $dbh->exec ("UPDATE money SET amt = amt - 6 WHERE name = 'Eve'");
     $dbh->exec ("UPDATE money SET amt = amt + 6 WHERE name = 'Ida'");
     $dbh->commit ();
  } catch (Exception $e) {
     print ("Transaction failed, rolling back. Error was:\n");
     print ($e->getMessage () . "\n");

     # empty exception handler in case rollback fails
     try
     {
       $dbh->rollback ();
     } catch (Exception $e2) { }
  }
  ```
