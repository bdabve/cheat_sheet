# <center>Views</center>

* To make the statement results easier to access, use a `view`, which is a virtual table that contains no data. 
* Instead, it’s defined as the `SELECT` statement that retrieves the data of interest

  ```sql
  mysql> CREATE VIEW V_mail_view AS
      -> SELECT
      -> DATE_FORMAT(t,'%M %e, %Y') AS date_sent,
      -> CONCAT(src_user,'@',src_host) AS sender,
      -> CONCAT(dst_user,'@',dst_host) AS recipient,
      -> size FROM mail;

  mysql> SELECT date_sent, sender, size FROM V_mail_view WHERE size > 100000 ORDER BY size;

  -- Table Animal

  mysql> CREATE VIEW V_animal_details AS 
      -> SELECT a.id, a.sexe, a.date_naissance, a.nom, a.commentaires, a.espece_id, a.race_id, a.mere_id, a.pere_id, a.disponible, 
      -> e.nom_courant AS espece_nom, r.nom AS race_nom FROM Animal AS a
      -> INNER JOIN Espece AS e ON a.espece_id = e.id
      -> LEFT JOIN Race AS r ON a.race_id = r.id;

  mysql> DESCRIBE V_animal_details;
  mysql> SELECT * FROM V_animal_details;
  ```
* Il existe une autre possibilité que le recours aux alias dans la clause `SELECT`  pour nommer les colonnes d'une vue. 
* Il suffit de lister les colonnes juste après le nom de la vue, lors de la création de celle-ci.
* `OR REPLACE`: Si elle est fournie, la vue nom_vue sera soit créée, si elle n'existe pas, soit remplacée, si elle existait déjà. 

  ```sql
  mysql> CREATE VIEW V_animal_details
      -> (id, sexe, date_naissance, nom, commentaire, espece_id, race_id, mere_id, pere_id, disponible, espece_nom, race_nom)
      -> AS SELECT
      -> a.id, a.sexe, a.date_naissance, a.nom, a.commentaires, a.espece_id, a.race_id, a.mere_id, a.pere_id, a.disponible, e.nom_courant, r.nom
      -> FROM Animal AS a
      -> INNER JOIN Espece AS e ON a.espece_id = e.id
      -> LEFT JOIN Race AS r ON a.race_id = r.id;

  mysql> SELECT * FROM V_animal_details WHERE id = 15;

  -- Une vue pour les chiens
  mysql> CREATE VIEW V_chien AS SELECT
      -> id, sexe, date_naissance, nom, commentaires, espece_id, race_id, mere_id, pere_id, disponible 
      -> FROM Animal WHERE espece_id = 1;

  -- Compte le nombre d'animaux de chaque espèce

  mysql> CREATE OR REPLACE VIEW V_nombre_espece AS SELECT 
      -> Espece.id, Espece.nom_courant, COUNT(Animal.id) AS nb_animaux FROM Espece 
      -> LEFT JOIN Animal ON Animal.espece_id = Espece.id GROUP BY Espece.id;

  -- Vue sur une vue.
  mysql> CREATE OR REPLACE VIEW V_chien_race
      -> AS SELECT id, sexe, date_naissance, nom, commentaires , espece_id , race_id , mere_id , pere_id , disponible FROM V_chien
      -> WHERE race_id IS NOT NULL;

  -- Vue avec fonction
  mysql> CREATE OR REPLACE VIEW V_espece_dollars 
      -> AS SELECT id, nom_courant, nom_latin, description, ROUND(prix*1.30813, 2) AS prix_dollars FROM Espece;

  -- ALTER VIEW
  mysql> ALTER VIEW V_Espece_dollars
      -> AS SELECT id, nom_courant, nom_latin, description, ROUND(prix*1.30813, 2) AS prix_dollars
      -> FROM Espece;

  -- DROP VIEW
  mysql> DROP VIEW V_race;
  ```

* If you often need a given summary, a technique that enables you to avoid typing the summarizing expressions repeatedly is to use a view

  ```sql
  mysql> CREATE VIEW trip_summary_view AS
      -> SELECT
      -> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),1,NULL)) AS weekend_trips,
      -> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),NULL,1)) AS weekday_trips
      -> FROM driver_log;
      
  mysql> SELECT * FROM trip_summary_view;
  ```

### Algorithmes

* Les vues peuvent en effet utiliser deux algorithmes différents :

  * `MERGE` : les clauses de la requête sur la vue (WHERE, ORDER BY…) sont fusionnées à la requête définissant la vue ;
  * `TEMPTABLE` : une table temporaire est créée avec les résultats de la requête définissant la vue, et la requête de sélection sur la vue est ensuite exécutée sur cette table temporaire.

### Modification des données d'une vue

* Il est possible de modifier des données à partir d'une vue définie avec une jointure, à condition de ne modifier qu'une seule table.
* Les éléments suivants sont ainsi interdits dans une vue si l'on veut pouvoir modifier les données à partir de celle-ci :
  * `DISTINCT`
  * `LIMIT`
  * une fonction d'agrégation (`SUM()`, `COUNT()`, `MAX()`...)
  * `GROUP BY`
  * `HAVING`
  * `UNION`
  * Une sous-requete dans la clause `SELECT`
  
* On ne peut pas modifier les données à partir d'une vue qui est elle-même définie à partir d'une vue qui ne permet pas la modification des données.
* Ce n'est pas non plus possible à partir d'une vue dont la clause `WHERE` contient une sous-requête faisant référence à une des tables de la clause `FROM`.

  ```sql
  -- Modifie Animal
  mysql> UPDATE V_Animal_details SET commentaires = 'Rhume chronique' WHERE id = 21;

  -- Modifie Race
  mysql> UPDATE V_Animal_details SET race_nom = 'Maine Coon' WHERE race_nom = 'Maine coon';

  -- Erreur
  mysql> UPDATE V_Animal_details SET commentaires = 'Vilain oiseau', espece_nom = 'Perroquet pas beau' WHERE espece_id = 4;
  -- commentaires vient de Animal, et espece_nom vient de Espece
  > ERROR 1393 (HY000): Can not modify more than one base table through a join view 'elevage.v_animal_details'
  ```

* On peut insérer des données dans une vue si celle-ci respecte les mêmes conditions que pour la modification de données, ainsi que les conditions supplémentaires suivantes.

***

## <center>Vues matérialisées</center>

* Une vue matérialisée est un objet qui permet de stocker le résultat d'une requête `SELECT`. 
* Là où une vue se contente de stocker la requête, la vue matérialisée va stocker directement les résultats (elle va donc les matérialiser), plutôt que la requête. 
* Lorsque l'on fait une requête sur une vue matérialisée, on va donc chercher directement des données dans celle-ci, sans passer par les tables d'origine et/ou une table temporaire intermédiaire.

* Malheureusement, MySQL ne propose pas encore ce type d'objet. Il faut donc se débrouiller avec les outils disponibles.

  ```sql
  -- On veut matérialiser V_Revenus_annee_espece
  mysql> CREATE TABLE VM_revenues_annee_espece
      -> ENGINE = InnoDB
      -> SELECT YEAR(date_reservation) AS annee, Espece.id AS espece_id, SUM(Adoption.prix) AS somme, COUNT(Adoption.animal_id) AS Nb
      -> FROM Adoption
      -> INNER JOIN Animal ON Animal.id = Adoption.animal_id
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id
      -> GROUP BY annee, Espece.id;
  ```

### Mise à jour des vues matérialisées

* On l'a dit, il ne suffit pas de créer une vue matérialisée à partir des données, il faut aussi la tenir à jour lorsque les données des tables d'origine changent.
* Deux possibilités:
  * Une mise à jour sur demande danc on peut utiliser une procédure stockées.
  
    ```sql
    mysql> CREATE PROCEDURE maj_vm_revenus()
        -> BEGIN
        ->   TRUNCATE VM_revenues_annee_espece;
        ->   INSERT INTO VM_revenues_annes_espece
        ->   SELECT YEAR(date_reservation) AS annee, Espece.id AS espece_id, SUM(Adoption.prix) AS somme, COUNT(Adoption.animal_id) AS Nb
        ->   FROM Adoption
        ->   INNER JOIN Animal ON Animal.id = Adoption.animal_id
        ->   INNER JOIN Espece ON Animal.espece_id = Espece.id GROUP BY annee, Espece.id;
        -> END$$

    mysql> CALL maj_vm_revenus();
    ```

  * Une mise à jour automatique chaque fois qu'un changement est faut: Avec les triggers
  
    ```sql
    -- On insert
    mysql> CREATE TRIGGER after_insert_adoption AFTER INSERT ON Adoption
        -> FOR EACH ROW
        -> BEGIN
        ->   INSERT INTO VM_revenues_annee_espece(espece_id, annee, somme, Nb)
        ->   SELECT espece_id, YEAR(NEW.date_reservation), NEW.prix, 1 FROM Animal  WHERE id = NEW.animal_id
        ->   ON DUPLICATE KEY UPDATE somme = somme + NEW.prix, Nb = Nb + 1;
        -> END$$

    -- ON update
    mysql> CREATE TRIGGER after_update_adoption AFTER UPDATE ON Adoption
        -> FOR EACH ROW
        -> BEGIN
        -> 
        ->   INSERT INTO VM_revenues_annee_espece(espece_id, annee, somme, Nb)
        ->   SELECT espece_id, YEAR(NEW.date_reservation), NEW.prix, 1 FROM Animal
        ->   WHERE id = NEW.animal_id
        ->   ON DUPLICATE KEY UPDATE somme = somme + NEW.prix, Nb = Nb + 1;
        -> 
        ->   UPDATE VM_revenues_annee_espece
        ->   SET somme = somme - OLD.prix, Nb = Nb - 1
        ->   WHERE annee = YEAR(OLD.date_reservation)
        ->   AND espece_id = (SELECT espece_id FROM Animal WHERE id = OLD.animal_id);
        -> 
        ->   DELETE FROM VM_revenues_annee_espece WHERE nb = 0;
        -> END$$

    -- On delete
    mysql> CREATE TRIGGER after_delete_adoption AFTER DELETE
        -> ON Adoption FOR EACH ROW
        -> BEGIN
        ->     UPDATE VM_Revenus_annee_espece SET somme = somme - OLD.prix, nb = nb - 1
        ->     WHERE annee = YEAR(OLD.date_reservation)  AND espece_id = (SELECT espece_id FROM Animal WHERE id = OLD.animal_id);
        ->  
        ->     DELETE FROM VM_Revenus_annee_espece WHERE nb = 0;
        -> END |
    ```


***


## <center>Verrous</center>

* Lorsqu'une session MySQL pose un verrou sur un élément de la base de données, cela veut dire qu'elle restreint, voire interdit, l'accès à cet élément aux autres sessions MySQL qui voudraient y accéder.

### Verrous de table et verrous de ligne

* Il est possible de poser un verrou sur une **table** entière, ou seulement sur une ou plusieurs lignes d'une table. 
* Étant donné qu'un verrou empêche l'accès d'autres sessions, il est en général plus intéressant de poser un verrou sur la plus petite partie de la base possible.

* En effet, prenons l'exemple d'un site web. 
* En général, on préfère permettre à plusieurs utilisateurs de surfer en même temps, sans devoir attendre entre chaque action de pouvoir accéder aux informations chacun à son tour. 
* Or, chaque utilisateur crée une session chaque fois qu'ilse connecte à la base de données (pour lire les informations ou les modifier).
Préférez donc (autant que possible) les verrous de ligne aux verrous de table !

### Syntaxe et utilisation : verrous de table

* Pour verrouiller une table, il faut utiliser la commande `LOCK TABLES` :

  ```sql
  LOCK TABLES nom_table [AS alias_table] [READ | WRITE] [, ...];
  ```
  
  * `READ`: un verrou de lecture, les autres sessions pourront toujours lire les données des tables verrouillées, mais ne pourront plus les modifier.
  * `WRITE`: un verrou d'écriture, Les autres sessions ne pourront plus ni lire ni modifier les données des tables verrouillées.

* Pour déverrouiller les tables, on utilise `UNLOCK TABLES`. 
* Cela déverrouille toutes les tables verrouillées. Il n'est pas possible de préciser les tables à déverrouiller. 
* Tous les verrous de table d'une session sont relâchés en même temps.

* Exemples : on pose deux verrous, `READ`, `WRITE`, l'un en donnant un `alias` au nomde la table, l'autre sans.

  ```sql
  LOCK TABLES Espece READ,      -- On pose un verrou de lecture sur Espece
  Adoption AS adopt WRITE;      -- et un verrou d'écriture sur Adoption avec l'alias adopt 
  
  SELECT id, nom_courant FROM Espece;                   -- Pas de probleme

  SELECT id, nom_courant FROM Espece AS table_espece;
  -- ERROR 1100 (HY000): Table 'table_espece' was not locked with LOCK TABLES

  UPDATE Espece SET description = 'Petit piaf bruyant' WHERE id = 4; 
  -- ERROR 1099 (HY000): Table 'Espece' was locked with a READ lock and can't be updated
  
  SELECT client_id, animal_id FROM Adoption;
  -- ERROR 1100 (HY000): Table 'Adoption' was not locked with LOCK TABLES 

  SELECT client_id, animal_id FROM Adoption AS Adopt;   -- Pas de probleme

  UPDATE Adoption SET paye = 0 WHERE client_id = 10 AND animal_id = 49; 
  -- ERROR 1100 (HY000): Table 'Adoption' was not locked with LOCK TABLES 

  UPDATE Adoption AS Adopt SET paye = 0 WHERE client_id = 10 AND animal_id = 49;
  ```

* Pour utiliser à la fois les transactions et les verrous de table, il faut renoncer à démarrer explicitement les transactions, et donc utiliser le mode non-autocommit. 
* Lorsque l'on est dans ce mode, il est facile de contourner la validation implicite provoquée par `LOCK TABLES`  et `UNLOCK TABLES`  : il suffit d'appeler `LOCK TABLES`  avant toute modification de données, et de commiter/annuler les modifications avant d'exécuter `UNLOCK TABLES`.

  ```sql
  SET autocommit = 0;
  LOCK TABLES Adoption WRITE; 
      -- La validation implicite ne commite rien puisque aucun changement n'a été fait

  UPDATE Adoption SET date_adoption = NOW() WHERE client_id = 9 AND animal_id = 54;
  SELECT client_id, animal_id, date_adoption FROM Adoption WHERE client_id = 9;

  ROLLBACK;
  UNLOCK TABLES; 
      -- On a annulé les changements juste avant donc la validation implicite n'a aucune conséquence
  SELECT client_id, animal_id, date_adoption FROM Adoption WHERE client_id = 9;
  SET autocommit = 1;
  ```
  
### Syntaxe et utilisation : verrous de ligne

* Comme les verrous de table, les verrous de ligne peuvent être de deux types :
  
  * Les verrous partagés : permettent aux autres sessions de lire les données, mais pas de les modifier (équivalents aux verrous de table de lecture) ;

  * Les verrous exclusifs : ne permettent ni la lecture ni la modification des données (équivalents aux verrous d'écriture).
 
#### Requêtes de sélection

* Les requêtes de sélection, par défaut, ne posent pas de verrous. Il faut donc en poser explicitement au besoin.
* Verrou partagé
  * Pour poser un verrou partagé, on utilise `LOCK IN SHARE MODE`  à la fin de la requête `SELECT`.
  
  ```sql
  SELECT * FROM Animal WHERE espece_id = 5 LOCK IN SHARE MODE;
  -- Signifie pour les autres sessions : "Je suis en train de lire ces données. Vous pouvez venir les lire aussi, mais pas les modifier tant que je n'ai pas terminé."
  ```

* Verrou exclusif: Pour poser un verrou exclusif, on utilise `FOR UPDATE`  à la fin de la requête `SELECT`.

  ```sql
  SELECT * FROM Animal WHERE espece_id = 5 FOR UPDATE;
  -- Signifie aux autres sessions : "Je suis en train de lire ces données dans le but probable de faire une modification. Ne les lisez pas avant que j'aie fini (et bien sûr, ne les modifiez pas)." 
  ```

