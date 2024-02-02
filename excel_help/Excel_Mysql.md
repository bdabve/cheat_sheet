


Insérer des données d’un fichier Excel ou Access dans MySQL
=================================

### Installation du pilote
> vous devez installer un pilote ODBC pour MySQL.

### Création de la source de données:
>* Pour qu’Access puisse communiquer avec MySQL, il a besoin d’un pilote mais aussi d’une source de données, habituellement appelée DSN (Data Source Name) ; c’est elle qui va indiquer sur quel serveur et quelle base se connecter.
>* Configuration > Système et sécurité > Outils d’administration > Sources de données (ODBC).
>* Dans « Source de données utilisateur », sélectionnez « Ajouter »
>* Vous avez la liste de tous les pilotes utiles pour les bases de données installés sur votre machine, sélectionnez donc « MySQL ODBC 5.1 Driver ».
> * « Terminer ».
  *  Choisissez donc un nom qui vous permettra de la retrouver facilement par la suite. 
  * Nom du serveur (localhost)
  * Nom d’utilisateur (par défaut, root sans mot de passe)
  * Sélectionnez dans la liste la base de données concernée.
  * Cliquez ensuite sur « Test » pour tester la connexion.
  * OK

### Connexion à MySQL Excel:
> * Données
> * A partir d'autre source
> * Provenance Assistant connexion de données
> * Dsn odbc
> * Le nom q'on a choisi.