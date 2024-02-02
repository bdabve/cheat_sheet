<link rel="stylesheet" href="style.css">

## Table of Content

* [Creation de Base de Donnees](#creation-de-base-de-donnees)
* [Les Moteur de Table](#les-moteur-de-table)
* [MyISAM](#myisam)
* [InnoDB](#innodb)

***

* [Linux Main](file:///home/dabve/web_dev/sql/mySql/linux_main.md)
* [Windows Main]()

### Creation de Base de Donnees:

```sql
mysql> CREATE DATABASE db_name;                                   -- Create database
mysql> CREATE DATABASE db_name CHARACTER SET 'utf8';              -- Character set
mysql> CREATE DATABASE IF NOT EXISTS db_name CHARACTER SET 'utf8';

mysql> SHOW DATABASES;                      -- Afficher les base de donnees.
mysql> SHOW WORNINGS;                       -- Afficher les erreur.

mysql> DROP DATABASE db_name;               -- Drop Database
mysql> DROP DATABASE IF EXISTS db_name;

mysql> USE db_name;                         -- utiliser une base de donnees.

psql> \l[+]                 -- listing database inside psql
```

[*Return to the Top*](#table-of-content)

### Les Moteurs de Tables

* les moteurs de tables sont une spécificité de MySQL.
* Ce sont des moteurs de stockage.
* Cela permet de gérer différemment les tables selon l'utilité qu'on en a.
* Les deux moteurs les plus connus sont: `MyISAM` et `InnoDB`.


#### MyISAM

* C'est le moteur par défaut.
* Les commandes d'insertion et sélection de données sont particulièrement rapides sur les tables utilisant ce moteur.
* Cependant, il ne gère pas certaines fonctionnalités importantes comme les `Foreign Key`, les `Transaction`.
* Les tables `MyISAM` sont non-transactionnelles.

#### InnoDB

* Plus lent et plus gourmand en ressources que `MyISAM`, ce moteur gère les `Foreign Key` et les `Transaction`.
* De plus, en cas de crash du serveur, il possède un système de récupération automatique des données.
* Les tables `InnoDB` sont transactionnelles, donc supportent les transactions.

- Determine the current ENGINE

    ```sql
    mysql> SELECT ENGINE FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'db_name' AND TABLE_NAME = 'table_name';
    mysql> SHOW TABLE STATUS LIKE 'mail'\G

    -- Modification d'une table existant:
    mysql> ALTER TABLE table_name ENGINE=INNODB;
    ```

[*Return to the Top*](#table-of-content)
