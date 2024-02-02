# <center>Security</center>

## <center>Understanding the mysql.user Table</center>

* MySQL stores user account information in tables in the mysql system database. 
* The user table is the most important because it contains account names and credentials. 
* To see its structure, use this statement:

  ```sql
  mysql> SHOW CREATE TABLE mysql.user;
  ```

  * The User and Host columns identify the account. MySQL account names comprise a combination of username and hostname values. 
  * The `plugin`, `Password`, and `authentication_string` columns store authentication credentials. MySQL does not store literal passwords in the user sytem table because that is insecure. Instead, the server computes a hash value from the password and stores the hash string.
  * The plugin column indicates which authentication plugin the server uses to check credentials for clients that attempt to use the account. Different plug-ins implement password hashing methods of varying encryption strength. The following table shows the plug-ins
  
  * The Password column is used if the plugin column is `mysql_native_pass` word or `mysql_old_password`. An empty Password value means 'no password,'
  * The `authentication_string` column is for use by `plug-ins` that do not use the Password column. For example, `sha256_password` uses `authentication_string` to store `SHA-256` password hash values, which are cryptographically superior to native hashing but too long for the Password column.
  

## Managing User Accounts

* To create an account, use the `CREATE USER` statement, which creates a row in the mysql.user table. 

  ```sql
  CREATE USER 'user_name'@'host_name' IDENTIFIED BY 'password';
  CREATE USER 'user_name'@'host_name' IDENTIFIED WITH 'auth_plugin';
  ```
* `mysql_native_password`: Implements the default password hashing method.
* `mysql_old_password`: Is similar but uses a hashing method that is less secure and is now deprecated.
* `sha256_password`: authenticates using SHA-256 password hash values, which are more secue than `mysql_native_password`, but additional setup is required to use it. (Clients must connect using SSL or provide an RSA certificate).

  ```sql
  mysql> CREATE USER 'user_name'@'host_name' IDENTIFIED WITH 'mysql_native_password';
  mysql> SET old_passwords = 0;

  mysql> CREATE USER 'user_name'@'host_name' IDENTIFIED WITH 'mysql_old_password';
  mysql> SET old_passwords = 1;

  mysql> CREATE USER 'user_name'@'host_name' IDENTIFIED WITH 'sha256_password';
  mysql> SET old_passwords = 2;

  -- Set the account password
  mysql> SET PASSWORD FOR 'user_name'@'host_name' = PASSWORD('password');     -- PASSWORD() functions hashes the password according to the old_passwords values
  ```

### Writing an account-creation helper

* We can write a helper stored procedure named `create_user()`.

  ```sql
  mysql> delimiter $$
  mysql> CREATE PROCEDURE create_user(user TEXT, host TEXT, password TEXT, plugin TEXT)
      -> BEGIN
      ->   DECLARE account TEXT;
      ->   SET account = CONCAT(QUOTE(user), '@', QUOTE(host));
      ->   CALL exec_stmt(CONCAT('CREATE USER ',account, ' IDENTIFIED WITH ', QUOTE(plugin)));
      ->   IF password IS NOT NULL THEN
      ->     BEGIN
      ->       DECLARE saved_old_passwords INT;
      ->       SET saved_old_passwords = @@old_passwords;
      ->       CASE plugin
      ->         WHEN 'mysql_native_password' THEN SET old_passwords = 0;
      ->         WHEN 'mysql_old_password' THEN SET old_password = 1;
      ->         WHEN 'sha256_password' THEN SET old_password = 2;
      ->         ELSE SIGNAL SQLSTATE 'HY000'
      ->           SET MYSQL_ERRNO = 1525,
      ->             MESSAGE_TEXT = 'unhandled auth plugin';
      ->       END CASE;
      ->       CALL exec_stmt(CONCAT('SET PASSWORD FOR ', account, ' = PASSWORD(', QUOTE(PASSWORD), ')');
      ->       SET old_password = saved_old_passwords;
      ->     END;
      ->   END IF;
      -> IF server_version() >= 50607 AND user <> '' THEN
      ->   CALL exec_stmt(CONCAT('ALTER USER ',account, ' PASSWORD EXPIRE'));
      -> END IF;
      -> END;
      -> $$
  -- To use the procedure, invoke it like this:
  mysql> CALL create_user('user_name','host_name','password','auth_plugin');
  ```

### Assigning and checking privileges

* Granting privileges globally enables the account to perform administrative operations or operations on any database:

  ```sql
  mysql> GRANT FILE ON *.* TO 'user'@'localhost';
  mysql> REVOKE FILE ON *.* FROM 'user'@localhost;      -- Remove privileges.

  mysql> GRANT CREATE TEMPORARY TABLES, LOCK TABLES ON *.* TO 'user'@'localhost';
  mysql> REVOKE CREATE TEMPORARY TABLES, LOCK TABLES ON *.* FROM 'user'@'localhost';  -- Remove privileges.
  ```

* Granting privileges at the database level enables the account to perform operations on objects within the named DB

  ```sql
  mysql> GRANT ALL ON cookbook.* TO 'user'@'localhost';
  mysql> REVOKE ALL ON cookbook.* FROM 'user'@'localhost';    -- Remove privileges.
  ```

* Granting privileges at the table level enbles the account to perform operation on a named table

  ```sql
  mysql> GRANT SELECT ON mysql.user TO 'user'@'localhost';
  mysql> REVOKE SELECT ON mysql.user FROM 'user'@'localhost';    -- Remove privileges.     
  ```

* Granting privileges at the column level enables the account to perform operations on the named table column

  ```sql
  mysql> GRANT SELECT(user, host), UPDATE(password_expired) ON mysql.user TO 'user'@'localhost';
  mysql> REVOKE SELECT(user, host), UPDATE(password_expired) ON mysql.user FROM 'user'@'localhost';     -- Remove privileges.
  ```

* Granting privileges at the procedure level enables the account to perform operations on the named procedure

  ```sql
  mysql> GRANT EXECUTE ON PROCEDURE cookbook.exec_stmt TO 'user'@'localhost';  -- Use FUNCTION rather than PROCEDURE if the routine is a stored function

  mysql> REVOKE EXECUTE ON PROCEDURE cookbook.exec_stmt FROM 'user'@'localhost';   -- Remove privileges
  ```

* To verify the privileges assignments, use `SHOW GRANTS`

  ```sql
  mysql> SHOW GRANTS FOR 'user'@'localhost';
  ```

* **Removing Accounts** 

  ```sql
  mysql> DROP USER 'user'@'localhost';
  ```

* **Renaming Accounts** 

  ```sql
  mysql> RENAME USER 'currentuser'@'localhost' TO 'newuser'@'localhost';
  ```

## <center>Passwords</center>

### Implementing a Password Policy

* Use the validate_password plug-in to implement a password policy. New passwords must satisfy the policy
* This technique requires the `validate_password` plug-in to be enabled

  ```sql
  mysql> INSTALL PLUGIN validate_password SONAME 'validate_password.so';
  ```

* When `validate_password` is enabled, it exposes a set of system variables that enable you to configure it.

  ```sql
  mysql> SHOW VARIABLES LIKE 'validate_password%';
  ```

* To put that policy in place, start the server with options that enable the plug-in and set the values of the system variable.

  ```bash
  [mysqld]
  plugin-load-add=validate_password.so        # Enbling the plug-in
  validate_password_length=10                 # Password length variable
  validate_password_mixed_case_count=1        # Contains upper and lower case
  validate_password_numer_count=2             # Contains 2 digit
  validate_password_special_char_count=1      # Contains al least on special (nonalphanumeric) character
  validate_password_policy=MEDIUM             # default: MEDIUM; and you can use LOW | STRONG
  ```

### Checking Password Strength 

* The validate_password plug-in not only implements policy for new passwords, it provides a SQL function, `VALIDATE_PASSWORD_STRENGTH()`, that enables strength testing of prospective passwords. 

* `VALIDATE_PASSWORD_STRENGTH()` returns a value from 0(weak) to 100(strong).

  ```sql
  mysql> SELECT VALIDATE_PASSWORD_STRENGTH('abc');
      -> 0
  ```

### Expiring Passwords

* MySQL 5.6.7 and up provides an `ALTER USER` statement that enables an administrator to expire an account’s password:

  ```sql
  mysql> ALTER USER 'cbuser'@'localhost' PASSWORD EXPIRE;
  mysql> UPDATE mysql.user SET password_expired = 'Y' WHERE User <> '';  -- Expire passwords for all non anonymous account at once
  mysql> FLUCH PRIVILEGES;
  ```

### Assigning Yourself a New Pass

* To assign yourself a new password, use the `SET PASSWORD` statement and the.

  ```sql
  mysql> SET PASSWORD = PASSWORD('my-new-password');
  mysql> SET PASSWORD FOR 'user'@'localhost' = 'password';

  mysql> UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'username' and Host = 'hostname';
  mysql> FLUSH PRIVILEGES;

  mysql> UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'username' and Host = 'hostname';

  mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
  ```

## Commandes de description

* `SHOW`
    
    ```sql
    SHOW TABLES;
    ```

* Objets listables avec `SHOW`

| Commande | Description 
|----------|-------------------------------
| `SHOW CHARACTER SET` | Montre les sets de caractères (encodages) disponibles.
| `SHOW [FULL] COLUMNS FROM nom_table [FROM nom_bdd]` | Liste les colonnes de la table précisée, ainsi que diverses informations (type, contraintes…). Il est possible de préciser également le nom de la base de données. En ajoutant le mot-clé `FULL`, les informations affichées pour chaque colonne sont plus nombreuses.
| `SHOW DATABASES` | Montre les bases de données sur lesquelles on possède des privilèges (ou toutes si l'on possède le privilège global SHOW DATABASES).
| `SHOW GRANTS [FOR utilisateur]` | Liste les privilèges de l'utilisateur courant, ou de l'utilisateur précisé par la clause `FOR` optionnelle.
| `SHOW INDEX FROM nom_table [FROM nom_bdd]` | Liste les index de la table désignée. Il est possible de préciser également le nom de la base de données.
| `SHOW PRIVILEGES` | Liste les privilèges acceptés par le serveur MySQL (dépend de la version de MySQL).
| `SHOW PROCEDURE STATUS` | Liste les procédures stockées.
| `SHOW [FULL] TABLES [FROM nom_bdd]` | Liste les tables de la base de données courante, ou de la base de données désignée par la clause `FROM`. Si FULL  est utilisé, une colonne apparaîtra en plus, précisant s'il s'agit d'une vraie table ou d'une vue.
| `SHOW TRIGGERS [FROM nom_bdd]` | Liste les triggers de la base de données courante, ou de la base de données précisée grâce à la clause `FROM`.
| `SHOW [GLOBAL \| SESSION] VARIABLES` | Liste les variables système de MySQL. Si `GLOBAL` est précisé, les valeurs des variables seront celles utilisées lors d'une nouvelle connexion au serveur. Si `SESSION` est utilisé (ou si l'on ne précise ni `GLOBAL`  ni `SESSION`), les valeurs seront celles de la session courante. Plus d'informations sur les variables système seront données dans le prochain chapitre.
| `SHOW WARNINGS` | Liste les avertissements générés par la dernière requête effectuée.

* Pour une liste exhaustive, la [documentation officielle](https://dev.mysql.com/doc/refman/5.5/en/show.html)

* Certaines commandes SHOW objets  acceptent des clauses supplémentaires : `LIKE`  et `WHERE`.
* La clause `LIKE`  permet de restreindre la liste aux objets dont le nom correspond au motif donné.
* `WHERE`  permet d'ajouter diverses conditions.

    ```sql
    SHOW COLUMNS FROM Adoption LIKE 'date%';
    SHOW CHARACTER SET WHERE Description LIKE '%arab%';
    ```
       
### `DESCRIBE`

* La commande `DESCRIBE` nom_table, qui affiche les colonnes d'une table ainsi que certaines de leurs caractéristiques, est en fait un raccourci pour `SHOW COLUMNS FROM nom_table`.

* La commande `SHOW` peut également montrer la requête ayant servi à créer un objet. `SHOW CREATE type_objet nom_objet;`
    
    ```sql
    SHOW CREATE TABLE Espece \G
    SHOW CREATE TRIGGER before_insert_adoption \G
    ```
    
    * Le `\G` est un délimiteur, comme `;`. Il change simplement la manière d'afficher le résultat, qui ne sera plus sous forme de tableau, mais formaté verticalement. 
    * Pour les requêtes de description comme `SHOW CREATE`, qui renvoient peu de lignes (ici : une), mais contenant beaucoup d'informations, c'est beaucoup plus lisible.
    
    
## La base de données information_schema

* Comme son nom l'indique, la base de données `information_schema` contient des informations sur les schémas.
* En MySQL, un schéma est une base de données. Ce sont des synonymes. La base `information_schema` contient donc des informations sur les bases de données.

    ```sql
    SHOW TABLES FROM information_schema;
    SHOW COLUMNS FROM VIEWS FROM information_schema;
    ```

## Déroulement d'une requête

* `EXPLAIN`: qui permet de décortiquer l'exécution d'une requête. Grâce à cette commande, il est possible de savoir quelles tables et quels index sont utilisés, et dans quel ordre.
* L'utilisation de cette commande est extrêmement simple : il suffit d'ajouter `EXPLAIN`  devant la requête que l'on désire examiner.  
* `EXPLAIN` peut être utilisée pour les requêtes `SELECT`, `UPDATE`, `DELETE`, `INSERT` et `REPLACE`.

    ```sql
    EXPLAIN SELECT Animal.nom, Espece.nom_courant AS espece, Race.nom AS race
    FROM Animal
    INNER JOIN Espece ON Animal.espece_id = Espece.id
    LEFT JOIN Race ON Animal.race_id = Race.id
    WHERE Animal.id = 37;
    ```
