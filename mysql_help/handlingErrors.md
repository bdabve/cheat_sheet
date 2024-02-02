## Gestion des erreurs

* Un gestionnaire d'erreurs définit une instruction (une seule !), ou un bloc d'instructions (BEGIN ... END;), qui va être exécuté en cas d'erreur correspondant au gestionnaire.

* Tous les gestionnaires d'erreurs doivent être déclarés au même endroit : après la déclaration des variables locales, mais avant les instructions de la procédure.

* Un gestionnaire peut soit provoquer l'arrêt de la procédure (`EXIT`), soit faire reprendre la procédure après avoir géré l'erreur (`CONTINUE`).

* On peut identifier le type d'erreur que le gestionnaire va reconnaître de trois manières différentes : un numéro d'erreur, un identifiant, ou une `CONDITION`.

* Un gestionnaire étant défini grâce au mot-clé `DECLARE`, comme les variables locales, il a exactement la même portée que celles-ci.

  ```sql
  mysql> CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
      -> BEGIN
      ->   DECLARE v_prix DECIMAL(7,2);
      ->   DECLARE EXIT HANDLER FOR SQLSTATE '23000'
      ->     BEGIN
      ->       SELECT 'Une erreur est survenue...';
      ->     END;
      ->   SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix FROM Animal
      ->   INNER JOIN Espece ON Espece.id = Animal.espece_id
      ->   LEFT JOIN Race ON Race.id = Animal.race_id WHERE Animal.id = p_animal_id;
      ->   
      ->   INSERT INTO Adoption(animal_id, client_id, date_reservation, date_adoption, prix, paye)
      ->   VALUES(p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);
      ->   
      ->   SELECT 'Fin procédure' AS message;
      -> END$$

  mysql> CREATE PROCEDURE ajouter_adoption_continue(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
      -> BEGIN
      ->   DECLARE v_prix DECIMAL(7,2);
      ->   DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Une erreur est survenue...';
      ->   SELECT 'Debut procedure';
      ->   SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix FROM Animal
      ->   INNER JOIN Espece ON Espece.id = Animal.espece_id
      ->   LEFT JOIN Race ON Race.id = Animal.race_id WHERE Animal.id = p_animal_id;
      ->   INSERT INTO Adoption(animal_id, client_id, date_reservation, date_adoption, prix, paye)
      ->   VALUES(p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);
      ->   SELECT 'Fin procédure';
      -> END$$

  mysql> CALL ajouter_adoption_exit(18, 6, @date_adoption, 1);
  mysql> CALL ajouter_adoption_continue(18, 6, @date_adoption, 1);
  ```

* Quelques exemples de codes souvent rencontrés
* Pour une liste plus complète, La [documentation officielle](https://dev.mysql.com/doc/refman/5.5/en/server-error-reference.html). 

| Code MySQL | SQLSTATE | Description
|:----------:|----------|----------------------
| 1048       | 23000    | La colonne x ne peut pas être NULL
| 1169       | 23000    | Violation de contrainte d'unicité
| 1216       | 23000    | Violation de clé secondaire : insertion ou modificationimpossible (table avec la clé secondaire)
| 1217       | 23000    | Violation de clé secondaire : suppression oumodification impossible(table avec la référence de la clé secondaire)
| 1172       | 42000    | Plusieurs lignes de résultats alors que l'on ne peut enavoir qu'une seule.
| 1242       | 21000    | La sous-requête retourne plusieurs lignes de résultats alors que l'on ne peut en avoir qu'une seule.

### Utilisation d'une `CONDITION`

* Une CONDITION  est simplement un nom donné à un numéro d'erreur MySQL ou à un identifiant d'état SQL. Cela vous permet de travailler avec des erreurs plus claires.

```sql
mysql> CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
    -> BEGIN
    ->   DECLARE v_prix DECIMAL(7,2);
    ->
    ->   -- Déclaration des CONDITION
    ->   DECLARE violation_cle_etrangere CONDITION FOR 1452;
    ->   DECLARE violation_unicite CONDITION FOR 1062;
    ->
    ->   -- Déclaration du gestionnaire pour les erreurs de clés étrangère
    ->   DECLARE EXIT HANDLER FOR violation_cle_etrangere
    ->     BEGIN
    ->       SELECT 'Erreur: violation de clé étrangere.';
    ->     END;
    ->   -- Déclaration du gestionnaire pour les errurs d'index unique
    ->   DECLARE EXIT HANDLER FOR violation_unicite
    ->     BEGIN
    ->       SELECT 'Erreur: violation de contrainte d''unicité.';
    ->     END;
    ->   -- Déclaration du gestionnaire pour toutes les autres erreurs au avertissements
    ->   DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    ->   BEGIN
    ->     SELECT 'Une erreur est survenue...';
    ->   END;
    ->
    ->   SELECT 'Debut procedure';
    ->
    ->   SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix FROM Animal
    ->   INNER JOIN Espece ON Espece.id = Animal.espece_id
    ->   LEFT JOIN Race ON Race.id = Animal.race_id WHERE Animal.id = p_animal_id;
    ->
    ->   INSERT INTO Adoption(animal_id, client_id, date_reservation, date_adoption, prix, paye)
    ->   VALUES(p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);
    ->   SELECT 'Fin procédure';
    -> END$$

SET @date_adoption = CURRENT_DATE() + INTERVAL 7 DAY;

mysql> CALL ajouter_adoption_exit(12, 3, @date_adoption, 1);        -- Violation unicité (animal 3 est déjà adopté)
mysql> CALL ajouter_adoption_exit(133, 6, @date_adoption, 1);       -- Violation clé étrangère (client 133 n'existe pas)
mysql> CALL ajouter_adoption_exit(NULL, 6, @date_adoption, 1);      -- Violation de contrainte NOT NULL
```

## Curseurs

* Les curseurs permettent de parcourir un jeu de résultats d'une requête SELECT, quel que soit le nombre de lignes récupérées, et d'en exploiter les valeurs. Quatre étapes sont nécessaires pour utiliser un curseur.

  * Déclaration du curseur : avec une instruction `DECLARE`.
  * Ouverture du curseur : on exécute la requête `SELECT`  du curseur et on stocke le résultat dans celui-ci.
  * Parcours du curseur : on parcourt une à une les lignes.
  * Fermeture du curseur.
  
  ```sql
  DECLARE curseur_client CURSOR FOR SELECT * FROM Client;
  OPEN nom_curseur;
  -- Parcours du curseur et instructions diverses
  FETCH nom_curseur INTO variable(s);   -- Parcours du curseur
  CLOSE nom_curseur;
  
  --Exemple
  
  mysql> CREATE PROCEDURE parcours_deux_clients()
      -> BEGIN
      ->   DECLARE v_nom, v_prenom VARCHAR(100);
      ->   DECLARE curs_clients CURSOR FOR SELECT nom, prenom FROM Client ORDER BY nom, prenom;
      ->
      ->   OPEN curs_clients;     -- Ouverture du curseur
      ->   FETCH curs_clients INTO v_nom, v_prenom;
      ->   -- On récupère la première ligne et on assigne les valeurs recuperees a nox variables locales
      ->   SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Premier client';
      ->   
      ->   FETCH curs_clients INTO v_nom, v_prenom;
      ->   -- On recupere la seconde ligne et on assign les valeurs recuperees a nos variables locales
      ->   SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Second client';
      ->   CLOSE curs_clients; -- Fermeture du curseur
      -> END$$
  
  mysql> CALL parcours_deux_clients();
  ```

* Cependant, la plupart du temps, on ne veut pas seulement utiliser les deux premières lignes, mais toutes ! Or, sauf exception, on ne sait pas combien de lignes seront sélectionnées.

* On veut donc parcourir une à une les lignes de résultats et leur appliquer un traitement, sans savoir à l'avance combien de fois ce traitement devra être répété.
* Pour cela, on utilise une boucle ! `WHILE`, `REPEAT` ou `LOOP`. Il n'y a plus qu'à trouver une condition pour arrêter la boucle une fois tous les résultats parcourus.

  ```sql
  mysql> CREATE PROCEDURE test_condition2(IN p_ville VARCHAR(100))
      -> BEGIN
      ->   DECLARE v_nom, v_prenom VARCHAR(100);
      ->   DECLARE fin TINYINT DEFAULT 0;  -- Variable locale utilisée pour stopper la boucle
      ->   -- OR DECLARE fin BOOLEAN DEFAULT FALSE;
      ->   DECLARE curs_clients CURSOR FOR SELECT nom, prenom FROM Client WHERE ville = p_ville;
      ->   
      ->   -- Gestionnaire d'erreur pour la condition NOT FOUND
      ->   DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;  -- DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
      ->   OPEN curs_clients;
      ->   loop_curseur:LOOP
      ->     FETCH curs_clients INTO v_nom, v_prenom;
      ->     IF fin = 1 THEN LEAVE loop_curseur;      --OR  IF fin THEN LEAVE loop_curseur;
      ->     END IF;
      ->     SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Client';
      ->   END LOOP;
      ->   CLOSE curs_clients;
      -> END$$

  -- With while loop and FOUND_ROWS()
  mysql> CREATE PROCEDURE test_cond(IN p_ville VARCHAR(100))
      -> BEGIN
      ->   DECLARE v_nom, v_prenom VARCHAR(100);
      ->   DECLARE v_i INT DEFAULT 1;
      ->   DECLARE count INT;
      ->   DECLARE curs_clients CURSOR FOR SELECT nom, prenom FROM Client WHERE ville = p_ville;
      ->   OPEN curs_clients;
      ->   SELECT FOUND_ROWS() INTO count;
      ->     WHILE v_i <= count DO
      ->       FETCH curs_clients INTO v_nom, v_prenom;
      ->       SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Client';
      ->       SET v_i = v_i + 1;
      ->     END WHILE;
      ->   CLOSE curs_clients;
      -> END$$
  ```

### Transactions et gestion d'erreurs

* la procédure suivante prend en paramètre l'id d'un client et de deux animaux que le client veut adopter :

  ```sql
  mysql> CREATE PROCEDURE adoption_deux_ou_rien(p_client_id INT, p_animal_id_1 INT, p_animal_id_2 INT)
      -> BEGIN
      ->   DECLARE v_prix DECIMAL(7,2);

      ->  -- Gestionnaire qui annule la transaction et termine la procédure
      ->  DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;  

      ->  START TRANSACTION;

      ->  SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix FROM Animal
      ->  INNER JOIN Espece ON Espece.id = Animal.espece_id
      ->  LEFT JOIN Race ON Race.id = Animal.race_id WHERE Animal.id = p_animal_id_1;

      ->  INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
      ->  VALUES (p_animal_id_1, p_client_id, CURRENT_DATE(), CURRENT_DATE(), v_prix, TRUE);

      ->  SELECT 'Adoption animal 1 réussie' AS message;

      ->  SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix FROM Animal
      ->  INNER JOIN Espece ON Espece.id = Animal.espece_id
      ->  LEFT JOIN Race ON Race.id = Animal.race_id WHERE Animal.id = p_animal_id_2;

      ->  INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
      ->  VALUES (p_animal_id_2, p_client_id, CURRENT_DATE(), CURRENT_DATE(), v_prix, TRUE);

      ->  SELECT 'Adoption animal 2 réussie' AS message;

      ->  COMMIT;
      -> END$$

  CALL adoption_deux_ou_rien(2, 43, 55);  -- L'animal 55 a déjà été adopté

  -- La procédure s'interrompt, puisque la seconde insertion échoue. 
  -- On n'exécute donc pas le second SELECT. Ici, grâce à la transaction et au ROLLBACK  du gestionnaire, la première insertion a été annulée.
  ```

### Préparer une requête dans un bloc d'instructions

* Pour finir, on peut créer et exécuter une requête préparée dans un bloc d'instructions. 
* Ceci permet de créer des requêtes dynamiques, puisque l'on prépare une requête à partir d'une chaîne de caractères.

  ```sql
  mysql> CREATE PROCEDURE select_race_dynamique(p_clause VARCHAR(255))
      -> BEGIN
      ->   SET @sql = CONCAT('SELECT nom, description FROM Race ', p_clause);

      ->   PREPARE requete FROM @sql;
      ->   EXECUTE requete;
      -> END$$

  -- Affichera les races de chats
  CALL select_race_dynamique('WHERE espece_id = 2');
   -- Affichera les deux premières races par ordre alphabétique de leur nom
  CALL select_race_dynamique('ORDER BY nom LIMIT 2');
  ```
  
## <center>Handling Errors Within Stored Programs</center>

### Catching and Ignoring Errors

* If you consider an error benign, you can use a handler to ignore it. For example, many `DROP` statements in MySQL have an `IF EXISTS` clause to suppress errors if objects to be dropped do not exist. 
* But some `DROP` statements have no such clause and thus no way to suppress errors. `DROP USER` is one of these:
* To prevent errors from occurring for nonexistent users, invoke `DROP USER` within a stored procedure that catches 1396 code and ignore it

  ```sql
  mysql> CREATE PROCEDURE drop_user(user TEXT, host TEXT)
      -> BEGIN
      ->    DECLARE account TEXT;
      ->    DECLARE CONTINUE HANDLER FOR 1396
      ->    SELECT CONCAT('Unknown user: ', account) AS Message;
      ->    SET account = CONCAT(QUOTE(user),'@',QUOTE(host));
      ->    CALL exec_stmt(CONCAT('DROP USER ',account));
      -> END$$
  
  -- Testing
  mysql> CALL drop_user('bad-user','localhost');
  +--------------------------------------+
  | Message                              |
  +--------------------------------------+
  | Unknown user: 'bad-user'@'localhost' |
  +--------------------------------------+
  ```

* Another example

  ```sql
  mysql> CREATE PROCEDURE table_n(table_name TEXT) 
      -> BEGIN 
      ->    DECLARE CONTINUE HANDLER FOR 1146 
      ->    SELECT CONCAT('Unknown table: ', table_name) AS Message; 
      ->    CALL exec_stmt(CONCAT('SELECT * FROM ', table_name)); 
      -> END$$

  -- Calling
  mysql> call table_n('bad_table');
  +--------------------------+
  | Message                  |
  +--------------------------+
  | Unknown table: bad_table |
  +--------------------------+
  ```
  
* To ignore the error completely, write the handler using an empty BEGIN … END block: 

  ```sql
  mysql> DECLARE CONTINUE HANDLER FOR 1396 BEGIN END;
  ```

### Raising Errors and Warnings

* To produce your own errors within a stored program when you detect something awry, use the `SIGNAL` statement.
* Suppose that an application performs a division operation for which you expect that the divisor will never be zero, and that you want to produce an error otherwise.

  ```sql
  mysql> SET sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO, STRICT_ALL_TABLES';
  mysql> SELECT 1/0;
  ```
  
* To ensure a devide-by-zero error in any context, write a function that performs the division but checks the divisor first and uses `SIGNAL` to raise an error

  ```sql
  mysql> CREATE FUNCTION divide(numerator FLOAT, divisor FLOAT)
      -> RETURNS FLOAT DETERMINISTIC
      -> BEGIN
      ->   IF divisor = 0 THEN
      ->     SIGNAL SQLSTATE '22012'
      ->       SET MYSQL_ERRNO = 1365, MESSAGE_TEXT = 'Unexpected 0 divisor';
      ->   END IF;
      ->   RETURN numerator / divisor;
      -> END;
      -> $$

  -- Test the function
  mysql> SELECT divide(1,0);
      -> ERROR 1365 (22012): unexpected 0 divisor
  ```
  
  * The `SIGNAL` statement specifies a `SQLSTATE` value plus an optional `SET` clause you can use to assign values to error attributes. 
  * `MYSQL_ERRNO` corresponds to the `MySQL-specific` error code, and `MESSAGE_TEXT` is a string of your choice.

* `SIGNAL` can also raise warning conditions, not just errors.

  ```sql
  mysql> CREATE PROCEDURE drop_user_warn(user TEXT, host TEXT)
      -> BEGIN
      ->   DECLARE account TEXT;
      ->   DECLARE CONTINUE HANDLER FOR 1396
      ->   BEGIN
      ->     DECLARE msg TEXT;
      ->     SET msg = CONCAT('Unknown user: ', account);
      ->     SIGNAL SQLSTATE '01000' SET MYSQL_ERRNO = 1642, MESSAGE_TEXT = msg;
      ->   END;
      -> SET account = CONCAT(QUOTE(user),'@',QUOTE(host));
      -> CALL exec_stmt(CONCAT('DROP USER ',account));
      -> END;

  -- Calling
  mysql> CALL drop_user_warn('bad-user','localhost');
  Query OK, 0 rows affected, 1 warning (0.00 sec)
  mysql> SHOW WARNINGS;
  +---------+------+--------------------------------------+
  | Level   | Code | Message                              |
  +---------+------+--------------------------------------+
  | Warning | 1642 | Unknown user: 'bad-user'@'localhost' |
  +---------+------+--------------------------------------+
  ```

### Using Triggers to Preprocess or Reject Data

* Reject bad data by raising a signal. This gives you access to stored program logic for more latitude in checking values than is possible with static constraints such as `NOT NULL` .
* Preprocess values and modify them, if you won’t want to reject them outright. 
* For example, map out-of-range values to be in range or sanitize values to put them in canonical form, if you permit entry of close variants.

* Suppose that you have a table of contact information such as name, state of residence, email address, and website URL:

  ```sql
  mysql> CREATE TABLE contact_info
      -> (
      ->  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      ->  name VARCHAR(30),
      ->  state CHAR(2),           -- State of residence
      ->  email VARCHAR(50),       -- Email address
      ->  url VARCHAR(255)         -- Web address
      -> );
  ```
* For entry of new rows, you want to enforce constraints or perform preprocessing as follows:
  * State of residence values are two-letter US state codes, valid only if present in the states table. (In this case, you could declare the column as an ENUM with 50 members, so it’s more likely you’d use this lookup-table technique with columns for which the set of valid values is arbitrarily large or changes over time.)
  * Email address values must contain an @ character to be valid.
  * For website URLs, strip any leading http:// to save space.
  
  ```sql
  mysql> CREATE TRIGGER bi_contact_info BEFORE INSERT ON contact_info
      -> FOR EACH ROW
      -> BEGIN
      ->   IF (SELECT COUNT(*) FROM states WHERE abbrev = NEW.state) = 0 THEN
      ->     SIGNAL SQLSTATE 'HY000'
      ->       SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'Invalid state code';
      ->   END IF;
      ->   IF INSTR(NEW.email, '@') = 0 THEN
      ->     SIGNAL SQLSTATE 'HY000'
      ->       SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'Invalid email address';
      ->   END IF;
      ->   SET NEW.url = TRIM(LEADING 'http://' FROM NEW.url);
      -> END;

  -- Testing
  mysql> INSERT INTO contact_info (name, state, email, url) VALUES('Jen', 'NY', 'jen@email.com', 'http://www.example.com');
  Query OK, 1 row affected (0.22 sec)

  mysql> INSERT INTO contact_info(name, state, email, url) VALUES('Jen', 'XX', 'jen@example.com', 'http://www.example.com');
  ERROR 1525 (HY000): Invalid state code        -- Because 'XX' does not exists in state table

  mysql> INSERT INTO contact_info(name, state, email, url) VALUES('Jen', 'NY', 'jen', 'http://www.example.com');
  ERROR 1525 (HY000): Invalid email address
  ```

  * To also handle updates, define a `BEFORE UPDATE` trigger with the same body as bi_con tact_info.
