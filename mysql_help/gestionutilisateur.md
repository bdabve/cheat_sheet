# <center>Gestion des utilisateurs </center>

## Create User

```sql
CREATE USER 'user'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL ON db_name.* TO 'user'@'localhost';

GRANT ALL PRIVILEGES ON base_name.* TO "user"@"localhost" IDENTIFIED BY "passwd";

-- Connect to a Remote Host 
CREATE USER 'elodie'@'194.28.12.4' IDENTIFIED BY 'password';
CREATE USER 'user'@'myhost.example.com' IDENTIFIED BY 'pass';
GRANT ALL ON db_name.* TO 'user'@'myhost.example.com';

-- 'thibault' peut se connecter à partir de n'importe quel hôte dont l'adresse IP commence par 194.28.12.
CREATE USER 'thibault'@'194.28.12.%' IDENTIFIED BY 'basketball8';

-- joelle peut se connecter à partir de n'importe quel hôte du domaine brab.net
CREATE USER 'joelle'@'%.brab.net' IDENTIFIED BY 'singingisfun';

-- hannah peut se connecter à partir de n'importe quel hôte
CREATE USER 'hannah'@'%' IDENTIFIED BY 'looking4sun';
```

### Specifying connection parameters using option files

* Under unix, your personal option file is named `.my.cnf` in your home directory.
* To see the exact list of permitted option-file locations, invoke `mysql --help`

  ```
  # General client program connection options
  [client]
  host = localhost
  user = username
  password = pass

  # Option specific to the mysql program
  [mysql]
  skip-auto-rehash
  pager="/usr/bin/less -E"        # Specify pager for interactive mode
  ```

* To find out which options the `mysql` program will read from option files: `$ mysql --print-default`

### Suppression et Modification

```php
DROP USER 'login'@'host';                                       -- Suppression
RENAME USER 'max'@'localhost' TO 'maxim'@'localhost'            -- Modification
SET PASSWORD FOR 'maxim'@'194.28.12.%' = PASSWORD('basket8');
```

## Les Differents Privileges:

| Privilege | Action autorisee
| ------------------------------
| CREATE TABLE              | Creation de tables
| CREATE TEMPORARY TABLE    | Creation de tables tomporaires
| CREATE VIEW               | Creation de vues (il faut avoire le privilege SELECT sur les colonnes selectionees
| ALTER                     | Modificatio de table (avec ALTER TABLE)
| DROP                      | Suppressio de table, vues et bases de données
| CREATE ROUTINE            | Création de procédures stockées (et de fonctions stockées - non couvert dans ce cours)
| ALTER ROUTINE             | Modification et suppression de procédures stockées (et fonctions stockées)
| EXECUTE                   | Exécution de procédures stockées (et fonctions stockées)
| INDEX                     | Création et suppression d'index
| TRIGGER                   | Création et suppression de triggers
| LOCK TABLES               | Verrouillage de tables (sur lesquelles on a le privilège SELECT)
| CREATE USER               | Gestion d'utilisateur (commandes CREATE USER , DROP USER , RENAME USER et SET PASSWORD)

### Les différents niveaux d'application des privilèges

| Niveau | Application du privilège
| ----------------------------------
| \*.\* | Privilège global : s'applique à toutes les bases de données, à tous les objets. Un privilège de ce niveau sera stocké dans la table mysql.user.
| * | Si aucune base de données n'a été préalablement sélectionnée (avec USE nomBdd), c'est l'équivalent de *.* (privilège stocké dans mysql.user). Sinon, le privilège s'appliquera à tous les objets de la base de données qu'on utilise (et sera stocké dans la table mysql.db)
| nomBdd.\* |  Privilège de base de données : s'applique à tous les objets de la base nomBdd (stocké dans mysql.db)
| nomBdd.nomTable | Privilège de base de données : s'applique à tous les objets de la base nomBdd (stocké dans mysql.db).
| nomTable | Privilège de table : s'applique à la table nomTable de la base de données dans laquelle on se trouve, sélectionnée au préalable avec USE nomBdd (stocké dans mysql.tables_priv). 
| nomBdd.nomRoutine | S'applique à la procédure (ou fonction) stockée nomBdd.nomRoutine (privilège stocké dans mysql.procs_priv).

  ```php
  GRANT SELECT, 
        UPDATE ( nom , sexe , commentaires),
        DELETE,
        INSERT
  ON elevage.Animal TO 'john'@'localhost' IDENTIFIED BY 'exemple2012';

  GRANT SELECT
  ON TABLE elevage.Espece       -- On précise que c'est une table (facultatif) 
  TO 'john'@'localhost' IDENTIFIED BY 'change2012' ;

  GRANT CREATE ROUTINE, EXECUTE
  ON elevage.* TO 'john'@'localhost' ;
  ```

* Pour retirer un ou plusieurs privilèges à un utilisateur, on utilise la commande REVOKE

  ```php
  REVOKE DELETE ON elevage.Animal FROM 'john'@'localhost';
  ```

##  Les privilèges ALL, USAGE et GRANT OPTION:

### ALL


