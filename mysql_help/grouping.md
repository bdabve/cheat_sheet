# <center>Regroupement</center>

## Regroupement sur un critère

* Pour regrouper les lignes selon un critère, il faut utiliser `GROUP BY`, qui se place après l'éventuelle clause `WHERE` sinon directement après `FROM`, suivi du nom de la colonne à utiliser comme critère de regroupement.

  ```sql
  SELECT COUNT(*) AS nb_animaux FROM Animal GROUP BY espece_id;
  
  -- Que les males
  SELECT COUNT(*) AS nb_males FROM Animal WHERE sexe = 'M' GROUP BY espece_id;
  
  -- Avoir le nom des espèces directement.
  SELECT nom_courant, COUNT(*) AS nb_animaux FROM Animal
  INNER JOIN Espece ON Animal.espece_id = Espece.id
  GROUP BY nom_courant;
  ```

## Regroupement sur plusieurs critères

  ```sql
  -- On regroupe d'abord sur l'espèce, puis sur le sexe.
  SELECT nom_courant, sexe, COUNT(*) as nb_animaux FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant, sexe;
  
  -- On regroupe d'abord sur le sexe, puis sur l'espèce.
  SELECT nom_courant, sexe, COUNT(*) as nb_animaux FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY sexe,nom_courant;
  ```

## Super-agrégats

* `WITH ROLLUP`: Cette option va afficher des lignes supplémentaires dans la table de résultats. 
* Ces lignes représenteront des "super-groupes" (ou super-agrégats), donc des "groupes de groupes".
   
  ```sql
  SELECT nom_courant, COUNT(*) as nb_animaux FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant WITH ROLLUP;
  -- La ligne supplémentaire représente donc le regroupement de nos quatre groupes basé sur le critère `GROUP BY` nom_courant.

  -- Exemple avec deux critère de regroupement
  SELECT nom_courant, sexe, COUNT(*) as nb_animaux FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  WHERE sexe IS NOT NULL
  GROUP BY nom_courant, sexe WITH ROLLUP;
  ```
  
* Il est possible d'éviter d'avoir ces `NULL` dans les lignes des super-groupes. 
* Pour cela, on peut utiliser la fonction `COALESCE()`.
* Cette fonction prend autant de paramètres que l'on veut, et renvoie le premier paramètre non `NULL`.

  ```sql
  SELECT COALESCE(1, NULL, 3, 4);   -- 1
  SELECT COALESCE(NULL, 2);         -- 2
  SELECT COALESCE(NULL, NULL, 3);   -- 3
  ```

* Voici comment l'utiliser dans le cas des super-agrégats.

  ```sql
  SELECT COALESCE(nom_courant, 'Total'), COUNT(*) as nb_animaux FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant WITH ROLLUP;

  -- Groupement sur le sexe, sans éliminer les lignes pour les quelles le sexe n'est pas défini
  SELECT COALESCE(sexe, 'Total'), COUNT(*) AS nb_animaux
  FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id GROUP BY sexe WITH ROLLUP;
  ```
  
* Si vous utilisez ``COALESCE()`` dans ce genre de situation, il est impératif que vos critères de regroupement ne contiennent pas ``NULL`` (ou que vous éliminiez ces lignes-là). 
* Sinon, vous aurez "Total" à des lignes qui ne sont pas des super-groupes.
  
## Conditions sur les fonctions d'agrégation

* Il n'est pas possible d'utiliser la clause `WHERE` pour faire des conditions sur une fonction d'agrégation. 
* Donc, si l'on veut afficher les espèces dont on possède plus de 15 individus, la requête suivante ne fonctionnera pas.

  ```sql
  SELECT nom_courant, COUNT(*) FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  WHERE COUNT(*) > 15
  GROUP BY nom_courant;
  
  > ERROR 1111 (HY000): Invalid use of group function
  ```
  
* Il faut utiliser une clause spéciale : ``HAVING``. Cette clause se place juste après le ``GROUP BY``.

  ```sql
  SELECT nom_courant, COUNT(*) FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant
  HAVING COUNT(*) > 15;
  
  -- Avec alias
  SELECT nom_courant, COUNT(*) as nombre FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant
  HAVING nombre > 15;
  ```

* Les conditions données dans la clause `HAVING` ne doivent pas nécessairement comporter une fonction d'agrégation. 
* Les deux requêtes suivantes donneront par exemple des résultats équivalents :

  ```sql
  -- Deux conditions dans HAVING
  SELECT nom_courant, COUNT(*) as nombre FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  GROUP BY nom_courant
  HAVING nombre > 6 AND SUBSTRING(nom_courant, 1, 1) = 'C'; 

  SELECT nom_courant, COUNT(*) as nombre FROM Animal
  INNER JOIN Espece ON Espece.id = Animal.espece_id
  WHERE SUBSTRING(nom_courant, 1, 1) = 'C'                -- Une condition dans WHERE
  GROUP BY nom_courant
  HAVING nombre > 6;                                      -- Et une dans HAVING
  ```

* Exemple

  ```sql
  -- Combien avons-nous de perroquets mâles et femelles, et quels sont leurs noms
  mysql> SELECT sexe, COUNT(*), GROUP_CONCAT(nom SEPARATOR ', ')
      -> FROM Animal
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id
      -> WHERE nom_courant LIKE 'Perroquet%' GROUP BY sexe;

  -- Quelles sont les races dont nous ne possedons aucun individu
  mysql> SELECT Race.nom, COUNT(Animal.race_id) AS nombre FROM Race
      -> LEFT JOIN Animal ON Animal.race_id = Race.id
      -> GROUP BY Race.nom HAVING nombre = 0;

  -- Quelles sont les especes dont nous possedons moins de cinq males
  mysql> SELECT Espece.nom_courant, COUNT(espece_id) AS nombre FROM Espece
      -> LEFT JOIN Animal ON Animal.espece_id = Espece.id
      -> WHERE sexe = 'M' OR Animal.id IS NULL GROUP BY Espece.nom_courant HAVING nombre < 5;
  ```
