### Table of Contents

* [Sous Requette](#sousReq)
* [Union](#union)
* [Jointure](#jointure)

<a name="sousReq"/>

# <center>Sous Requette</center>

### Sous-requête pour l'insertion

```sql
mysql> INSERT INTO Animal (nom, sexe, date_naissance, race_id, espece_id)
    -> SELECT 'Yoda', 'M', '2010-11-09', id AS race_id, espece_id FROM Race WHERE nom = 'Maine coon';

-- Selecting plus petit peroquet et tortue
mysql> SELECT MIN(DATE(date_naissance)) AS 'Plus_petit (torute, perroquet)' 
    -> FROM (
    -> SELECT a.id, a.sexe, a.date_naissance, a.nom, a.espece_id FROM Animal AS a 
    -> INNER JOIN Espece AS e ON e.id = a.espece_id 
    -> WHERE e.nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')) AS tortues_peroquets;

mysql> SELECT id, nom, sexe, date_naissance, commentaires FROM Animal 
    -> WHERE NOT EXISTS(SELECT * FROM Adoption WHERE Animal.id = Adoption.animal_id );
```

### Modification

```sql
mysql> UPDATE Animal SET commentaires = 'Coco veut un gateau !'
    -> WHERE espece_id = (SELECT id FROM Espece WHERE nom_courant LIKE 'Perroquet%');
    
mysql> UPDATE Animal SET race_id = (SELECT id FROM Race WHERE nom = 'Nebelung' AND espece_id = 2) WHERE nom = 'Cawette';

-- Pour les tortues et les perroquets, si un animal n'a pas de commentaire, on lui ajoute comme commentaire la description de l'espèce.

mysql> UPDATE Animal
    -> INNER JOIN Espece ON Animal.espece_id = Espece.id
    -> SET Animal.commentaires = Espece.description
    -> WHERE Animal.commentaires IS NULL
    -> AND Espece.nom_courant IN ('Perroquet amazone', 'Tortue d''Hermann');

-- Metre les animaux adopte a FALSE
mysql> UPDATE Animal SET disponible = FALSE
    -> WHERE EXISTS(SELECT * FROM Adoption WHERE Animal.id = Adoption.animal_id)
```

### Suppression

```sql
mysql> DELETE FROM Animal WHERE nom = 'Carabistouille' AND espece_id = (SELECT id FROM Espece WHERE nom_courant = 'Chat');

mysql> DELETE Animal FROM Animal     -- Table principale
mysql> INNER JOIN Espece ON Animal.espece_id = Espece.id WHERE Animal.nom = 'Carabistouille' AND Espece.nom_courant = 'Chat';
```

***

<a name="union"/>

# <center>Union</center>

* `UNION`: Faire l'union de deux requêtes, cela veut simplement dire réunir les résultats de la première requête et les résultats de la seconde requête.

* Il est absolument indispensable que toutes les requêtes unies renvoient le même nombre de colonnes.
* si vous sélectionnez des colonnes de différents types, vous n'aurez pas d'erreur, mais vous aurez des résultats un peu spéciaux. 
  
  ```sql
  mysql> SELECT Animal.nom, Espece.nom_courant FROM Animal
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id WHERE Espece.nom_courant = 'Chat'
      -> UNION
      -> SELECT Animal.nom, Espece.nom_courant FROM Animal
      -> INNER JOIN Espece ON Animal.espece_id = Espece.id WHERE Espece.nom_courant = 'Tortue d''Hermann';
  ```

### UNION ALL

* `UNION`: est équivalent à `UNION DISTINCT`. 
* Si vous voulez conserver les doublons, vous devez utiliser `UNION ALL`.
  
  ```sql
  -- Chaque résultat n’apparaît qu'une seule fois
  SELECT * FROM Espece
  UNION
  SELECT * FROM Espece;
  
  mysql> SELECT * FROM Espece
      -> UNION ALL
      -> SELECT * FROM Espece;
  ```

### LIMIT et ORDER BY

* **LIMIT**

  ```sql
  mysql> (SELECT id, nom, 'Race' AS table_origine FROM Race LIMIT 3)
      -> UNION
      -> SELECT id, nom_latin, "Espèce" AS table_origine FROM Espece;
      
  mysql> SELECT id, nom, 'Race' AS table_origin FROM Race
      -> UNION
      -> (SELECT id, nom_latin, 'Espèce' AS table_origin FROM Espece LIMIT 2);
  ```

* **ORDER BY**

* `ORDER BY`  agit sur l'ensemble de la requête, donc en quelque sorte, sur une table intermédiaire composée des résultats des deux requêtes unies

  ```sql
  mysql> SELECT id, nom, 'Race' AS table_origine FROM Race
      -> UNION
      -> SELECT id, nom_latin, 'Espèce' AS table_origine FROM Espece ORDER BY nom DESC;
      
  mysql> (SELECT id, nom, 'Race' AS t_origine FROM Race LIMIT 6)
      -> UNION
      -> (SELECT id, nom_latin, 'Espèce' AS t_origine FROM Espece LIMIT3)
      -> ORDER BY nom LIMIT 5;
      
  mysql> (SELECT id, nom, 'Race' AS t_o FROM Race ORDER BY nom DESC LIMIT 6)
      -> UNION
      -> (SELECT id, nom_latin, 'Espèce' AS t_o FROM Espece LIMIT 3);
  ```

***

<a name="jointure"/>

# <center>Joining Tables</center>

## Types of Table Relationships

### **_One-to-One_** Relationship
Consider an example of joining two tables with state-by-state census data. 
One table might contain household income data and the other data on educational attainment. 
Both tables would have 51 rows (one for each state plus Washington, D.C.), and if we wanted to join them on a key such as state name, state abbreviation, or a standard geography code, we’d have only one match for each key value in each table.

### **_One-to-Many_** Relationship
In a one-to-many relationship, a key value in the first table will have multiple matching values in the second table’s joined column. 
Consider a database that tracks automobiles. 
One table would hold data on automobile manufacturers, with one row each for Ford, Honda, Kia, and so on. 
A second table with model names, such as Focus, Civic, Sedona, and Accord, would have several rows matching each row in the manufacturers’ table.

### **_Many-to-Many_** Relationship
In a many-to-many relationship, multiple rows in the first table will have multiple matching rows in the second table. 
As an example, a table of baseball players could be joined to a table of field positions. Each player can be assigned to multiple positions, and each position can be played by multiple people.

* The essential idea behind a join is that it matches rows in one table with rows in one or more other tables. 
* Joins enable you to combine information from multiple tables when each one answers only part of the question in which you’re interested.
* A complete join that produces all possible row combinations is called a Cartesian product. 

  ```sql
  -- Using a simple "WHERE" clause
  mysql> SELECT * FROM artist INNER JOIN painting WHERE artist.a_id = painting.a_id ORDER BY artist.a_id;

  -- Using an 'ON' clause
  mysql> SELECT * FROM artist INNER JOIN painting ON artist.a_id = painting.a_id ORDER BY artist.a_id;
  pgsl > SELECT * FROM employees JOIN departments ON employees.dept_id = departments.dept_id;

  -- If columns has the same name in both table, use 'USING' clause
  mysql> SELECT * FROM artist INNER JOIN painting USING(a_id) ORDER BY a_id;

  -- Include Comparisons
  mysql> SELECT * FROM artist INNER JOIN painting ON artist.a_id = painting.a_id WHERE painting.state = 'KY';
  mysql> SELECT * FROM artist INNER JOIN painting USING(a_id) WHERE painting.state = 'KY';

  -- Name only columns in which you're interested
  mysql> SELECT artist.name, painting.title, painting.state, painting.price
      -> FROM artist INNER JOIN painting
      -> USING(a_id) WHERE painting.state = 'KY';
  
  -- wich artist did you puchase paintings in KY or IN
  mysql> SELECT DISTINCT artist.name FROM artist 
      -> INNER JOIN painting USING(a_id) 
      -> WHERE painting.state IN ('KY', 'IN');

  -- How many paintings you have per artist
  mysql> SELECT artist.name, COUNT(*) AS 'Number of painting' FROM artist
      -> INNER JOIN painting USING(a_id)
      -> GROUP BY artist.name;

  -- Use aggregates to show how much paid for each artist's painting.
  mysql> SELECT artist.name, COUNT(*) AS 'number of painting', 
      -> SUM(painting.price) AS 'total price', AVG(painting.price) AS 'average price'
      -> FROM artist INNER JOIN painting USING(a_id) GROUP BY artist.name;
  ```

* To avoid writing complete table names, give each table a short alias and refer to its columns using tha alias

  ```sql
  mysql> SELECT a.name, p.title, s.name, p.price
      -> FROM artist AS a
      -> INNER JOIN painting AS p
      -> INNER JOIN states AS s
      -> ON a.a_id = p.a_id AND p.state = s.abbrev;
  ```

## JOIN Types:

- **_JOIN_**     : Returns rows from both tables where matching values are found in the joined columns of both tables, alternate syntax **_INNER JOIN_** 

- **_LEFT JOIN_**: Returns every row from the left table plus rows that match values in the joined column from the right table.  
  When a left table rows doesn't have a match in the right table, the result shows no values from the right table.

- **_RIGHT JOIN_**: Returns every row from the right table plus rows that match the key values in the key column from the left tabl
  When a right table rows doesn't have a match in the left, the result shows no values from the left table.
  > **_RIGHT JOIN_** like **_LEFT JOIN_** but reverses the roles of the left and right tables. 

- **_FULL OUTER JOIN_**: Returns every row from both tables and matches rows; then joins the rows where values in the joined
  columns match. 
  if there's no match for a value in either the left of right table, the result contains an empty row for the other table.

- **_CROSS JOIN_** : Returns every possible combination of rows both tables.

#### Suppose we have this two tables:
  ```
  - left table                                      - right table
  id  |       left_school                           id  |      right_school      
  ----+--------------------------                   ----+------------------------
  1   | Oak Street School                           1   | Oak Street School
  2   | Roosevelt High School                       2   | Roosevelt High School
  5   | Washington Middle School                    3   | Morrison Elementary
  6   | Jeffersion High School                      4   | Chase Magnet Academy
                                                    5   | Jeffersion High School
  ```

- **_JOIN_** OR **_INNER JOIN_**
  ```sql
  pgsql> SELECT * FROM schools_left AS sleft JOIN schools_right AS sright ON sleft.id = sright.id;

  id  |       left_school        | id |      right_school      
  ----+--------------------------+----+------------------------
  1   | Oak Street School        |  1 | Oak Street School
  2   | Roosevelt High School    |  2 | Roosevelt High School
  5   | Washington Middle School |  5 | Jeffersion High School
  ```
- **_LEFT JOIN_** and **_RIGHT JOIN_**

  ```sql
  pgsql> SELECT * FROM schools_left AS sleft LEFT JOIN schools_right AS sright ON sleft.id = sright.id;

   id |       left_school        | id |      right_school      
  ----+--------------------------+----+------------------------
    1 | Oak Street School        |  1 | Oak Street School
    2 | Roosevelt High School    |  2 | Roosevelt High School
    5 | Washington Middle School |  5 | Jeffersion High School
    6 | Jeffersion High School   |    | 

  pgsql> SELECT * FROM schools_left AS sleft RIGHT JOIN schools_right AS sright ON sleft.id = sright.id;
  id  |       left_school        | id |      right_school      
  ----+--------------------------+----+------------------------
  1   | Oak Street School        |  1 | Oak Street School
  2   | Roosevelt High School    |  2 | Roosevelt High School
      |                          |  3 | Morrison Elementary
      |                          |  4 | Chase Magnet Academy
  5   | Washington Middle School |  5 | Jeffersion High School
  ```

  > Syntactically, `tbl1 LEFT JOIN tbl2` is equivalent to `tbl2 RIGHT JOIN tbl1`. 
  
- **_FULL OUTER JOIN_**

  ```sql
  pgsql> SELECT * FROM schools_left AS sleft FULL OUTER JOIN schools_right as sright ON sleft.id = sright.id;
  id  |       left_school        | id |      right_school      
  ----+--------------------------+----+------------------------
  1   | Oak Street School        |  1 | Oak Street School
  2   | Roosevelt High School    |  2 | Roosevelt High School
  5   | Washington Middle School |  5 | Jeffersion High School
  6   | Jeffersion High School   |    | 
      |                          |  4 | Chase Magnet Academy
      |                          |  3 | Morrison Elementary
  ```
- **_CROSS JOIN_**
  ```sql
   id |       left_school        | id |      right_school      
  ----+--------------------------+----+------------------------
    1 | Oak Street School        |  1 | Oak Street School
    1 | Oak Street School        |  2 | Roosevelt High School
    1 | Oak Street School        |  3 | Morrison Elementary
    1 | Oak Street School        |  4 | Chase Magnet Academy
    1 | Oak Street School        |  5 | Jeffersion High School
    2 | Roosevelt High School    |  1 | Oak Street School
    2 | Roosevelt High School    |  2 | Roosevelt High School
    2 | Roosevelt High School    |  3 | Morrison Elementary
    2 | Roosevelt High School    |  4 | Chase Magnet Academy
    2 | Roosevelt High School    |  5 | Jeffersion High School
    5 | Washington Middle School |  1 | Oak Street School
    5 | Washington Middle School |  2 | Roosevelt High School
    5 | Washington Middle School |  3 | Morrison Elementary
    5 | Washington Middle School |  4 | Chase Magnet Academy
    5 | Washington Middle School |  5 | Jeffersion High School
    6 | Jeffersion High School   |  1 | Oak Street School
    6 | Jeffersion High School   |  2 | Roosevelt High School
    6 | Jeffersion High School   |  3 | Morrison Elementary
    6 | Jeffersion High School   |  4 | Chase Magnet Academy
    6 | Jeffersion High School   |  5 | Jeffersion High School
  ```

### Selecting Specific Columns in a Join

```sql
psql> SELECT sleft.id, sleft.left_school, sright.right_school FROM schools_left AS sleft 
   -> LEFT JOIN schools_right AS sright USING(id);

 id |       left_school        |      right_school      
----+--------------------------+------------------------
  1 | Oak Street School        | Oak Street School
  2 | Roosevelt High School    | Roosevelt High School
  5 | Washington Middle School | Jeffersion High School
  6 | Jeffersion High School   | 
```

- JOIN on multiple tables
  ```sql
  psql> SELECT lt.id, lt.left_school, en.enrollment, gr.grades FROM schools_left AS lt 
     -> LEFT JOIN schools_enrollment AS en ON lt.id = en.id
     -> LEFT JOIN schools_grades AS gr ON lt.id = gr.id;

  id  |       left_school        | enrollment | grades 
  ----+--------------------------+------------+--------
  1   | Oak Street School        |        360 | K-3
  2   | Roosevelt High School    |       1001 | 9-12
  5   | Washington Middle School |        450 | 6-8
  6   | Jeffersion High School   |        927 | 9-12
  ```

### Using NULL to Find Rows with Missing Values

```sql
pgsql> SELECT * FROM schools_left as sleft LEFT JOIN schools_right as sright ON sleft.id = sright.id
    -> WHERE sright.id IS NULL;
 id |      left_school       | id | right_school 
----+------------------------+----+--------------
  6 | Jeffersion High School |    | 

pgsql> SELECT * FROM schools_left as sleft RIGHT JOIN schools_right as sright ON sleft.id = sright.id
    -> WHERE sleft.id IS NULL;

 id | left_school | id |     right_school     
----+-------------+----+----------------------
    |             |  3 | Morrison Elementary
    |             |  4 | Chase Magnet Academy
```

***

- A similar kind of operation reports each left-table value along with an indicator as to whether it’s present in the right table.

  ```sql
  mysql> SELECT artist.name, 
      -> IF(COUNT(painting.a_id)>0,'Yes','No') AS 'In collection?'
      -> FROM artist LEFT JOIN painting USING(a_id) GROUP BY artist.name;
  ```
- Another way to identify values present in one table but missing from another is to use a `NOT IN` subquery. 

  ```sql
  mysql> SELECT * FROM artist WHERE a_id NOT IN (SELECT a_id FROM painting);
  ```

  ```sql
  mysql> SELECT artist.name, 
      -> IF(COUNT(painting.a_id)>0,'Yes','No') AS 'In collection?' 
      -> FROM painting RIGHT JOIN artist USING(a_id) GROUP BY artist.name; 
  ```

***

## <center>Syntaxes alternatives</center>

### Jointures naturelles:

* In the special case that you want to base the comparison on every column that appears in both tables, you can use `NATURAL LEFT JOIN` or `NATURAL RIGHT JOIN` and omit the `ON` or `USING` clause:

  ```sql
  mysql> SELECT * FROM artist NATURAL LEFT JOIN painting;
  mysql> SELECT * FROM artist NATURAL LEFT JOIN painting WHERE painting.a_id IS NULL;
  ```

***

###  Identifying and Removing Mismatched or Unattached Rows

* You want to determine whether there are records in either dataset that are “unattached” (not matched by any record in the other dataset), and perhaps remove them if so.

* To identify unmatched values in each table, use a LEFT JOIN or a NOT IN subquery. 
* To remove them, use `DELETE` with a `NOT IN` subquery

  ```sql
  --  find sales regions for which there are no sales volume rows
  mysql> SELECT s_region.region_id AS 'Unmatched region row IDs'
      -> FROM sales_region AS s_region LEFT JOIN sales_volume AS s_volume
      -> USING(region_id) WHERE s_volume.region_id IS NULL;

  -- With RIGHT JOIN
  mysql> SELECT s_region.region_id AS 'Unmatched region row ID\'s' 
      -> FROM sales_volume AS s_volume RIGHT JOIN sales_region AS s_region USING(region_id) 
      -> WHERE s_volume.region_id IS NULL;

  -- Find sales volume rows that are no associated with any known region
  mysql> SELECT sales_volume.region_id AS 'Unmatched volume row ID\'s'
      -> FROM sales_volume LEFT JOIN sales_region USING(region_id)
      -> WHERE sales_region.region_id IS NULL;

  -- With RIGHT JOIN
  mysql> SELECT sales_volume.region_id AS 'Unmatched volume row ID\'s' 
      -> FROM sales_region RIGHT JOIN sales_volume USING(region_id) 
      -> WHERE sales_region.region_id IS NULL;
  ```

* You can also identify mismatches using `NOT IN` subqueries

  ```sql
  mysql> SELECT region_id FROM sales_region -> WHERE region_id NOT IN (SELECT region_id FROM sales_volume);
  --
  mysql> SELECT DISTINCT region_id FROM sales_volume WHERE region_id NOT IN(SELECT region_id FROM sales_region);

  -- Delete
  mysql> DELETE FROM sales_region WHERE region_id NOT IN (SELECT region_id FROM sales_volume);
  mysql> DELETE FROM sales_volume WHERE region_id NOT IN (SELECT region_id FROM sales_region);
  ```

### Comparing a Table to Itself

* A special case of joining one table to another occurs when both tables are the same. 
* This is called a self-join. 
* This may be confusing or strange to think about at first, but it’s perfectly legal. 
* You’ll likely find yourself using self-joins quite often because they are so important

* Suppose that your favorite painting is The Potato Eaters, and you want to identify all items in your collection that were painted by the same artist.
* The solution is to alias at least one instance of the table so that you can distinguish column references by using different table qualifiers. 

  ```sql
  mysql> SELECT p2.title FROM painting AS p1 
      -> INNER JOIN painting AS p2 ON p1.a_id = p2.a_id WHERE p1.title = 'The Potato Eaters';

  -- To find only other paintings by the same artist, explicitly exclude the reference value
  mysql> SELECT p2.title, p2.a_id
      -> FROM painting AS p1 INNER JOIN painting AS p2 USING(a_id) 
      -> WHERE p1.title = 'The Potato Eaters' AND p2.title <> p1.title;

  -- Which states joined the Union in the same year as New York?
  mysql> SELECT s2.name, s2.statehood
      -> FROM states AS s1 INNER JOIN states AS s2
      -> ON YEAR(s1.statehood) = YEAR(s2.statehood) AND s1.name <> s2.name
      -> WHERE s1.name = 'New York' ORDER BY s2.name;

  -- Find every pair of states that joined the Union in the same year. 
  mysql> SELECT YEAR(s1.statehood) AS Year,
      -> s1.name AS Name1, s1.statehood AS statehood1,
      -> s2.name AS Name2, s2.statehood AS statehood2
      -> FROM states AS s1 INNER JOIN states AS s2
      -> ON YEAR(s1.statehood) = YEAR(s2.statehood) AND s1.name <> s2.name
      -> ORDER BY year, name1, name2;
  ```

###  Enumerating a Many-to-Many Relationship

* A many-to-many relationship between tables is more complex. 
* It occurs when a row in one table may have many matches in the other, and vice versa. 
* An example is the relationship between movies and actors: each movie may have multiple actors, and each
actor may have appeared in multiple movies. 

* To better represent this many-tomany relationship, use multiple tables:
  * Store each movie year and name once in a table named movies.
  * Store each actor name once in a table named actors.
  * Create a third table, movies_actors_link, that stores movie-actor associations and serves as a link, or bridge, between the two primary tables. 
  * To minimize the information stored in this table, assign unique IDs to each movie and actor within their respective tables, and store only those IDs in the movies_actors_link table.

  ```sql
  mysql> SELECT m.year, m.movie, a.actor FROM movies AS m
      -> INNER JOIN movies_actors_link AS l
      -> INNER JOIN actors AS a
      -> ON m.id = l.movie_id AND a.id = l.actor_id
      -> ORDER BY m.year, m.movie, a.actor;
      
  -- List the actors in a given movie
  mysql> SELECT m.movie, a.actor FROM movies AS m
      -> INNER JOIN movies_actors_link AS l
      -> INNER JOIN actors AS a
      -> ON m.id = l.movie_id AND a.id = l.actor_id
      -> WHERE m.movie = 'Red';
      
  -- List the movies in which a given actor has acted
  mysql> SELECT m.year, m.movie FROM movies AS m
      -> INNER JOIN movies_actors_link AS l
      -> INNER JOIN actors AS a
      -> ON a.id = l.actor_id AND m.id = l.movie_id
      -> WHERE a.actor = 'Liam Neeson' ORDER BY m.year, m.movie;
  ```
  
### Finding Per-Group Minimum or Maximum Values

* Create a temporary table to hold the per-group maximum or minimum values, then join the temporary table with the original one to pull out the matching row for each group. 
* If you prefer a single-query solution, use a subquery in the FROM clause rather than a temporary table.

  ```sql
  -- What is the most expensive painting in the collection, and who painted it?
  mysql> SELECT a.name, p.title, p.price FROM artist AS a
      -> INNER JOIN painting AS p
      -> USING(a_id) WHERE p.price = (@max_price);

  -- With Subquery
  mysql> SELECT a.name, p.title, p.price FROM artist AS a
      -> INNER JOIN painting AS p
      -> USING(a_id) WHERE p.price = (SELECT MAX(price) FROM painting);
  ```

* The same thing can be done by creating a temporary table to hold the maximum price and joining it with the other tables

  ```sql
  -- Creating the tmp table
  mysql> CREATE TABLE tmp SELECT MAX(price) AS max_price FROM painting;

  -- Execute our stmt
  mysql> SELECT a.name, p.title, p.price FROM artist AS a
      -> INNER JOIN painting AS p
      -> INNER JOIN tmp
      -> ON p.a_id = a.a_id AND p.price = tmp.max_price;

  -- Another complicated example 
  mysql> CREATE TABLE tmp
      -> SELECT a_id, MAX(price) AS max_price FROM painting GROUP BY a_id;
  -- 
  mysql> SELECT a.name, p.title, p.price FROM artist AS a
      -> INNER JOIN painting AS p
      -> INNER JOIN tmp
      -> ON a.a_id = p.a_id AND p.price = tmp.max_price;

  -- With Subquery
  mysql> SELECT a.name, p.title, p.price FROM artist AS a
      -> INNER JOIN painting AS p
      -> INNER JOIN (SELECT a_id, MAX(price) AS max_price FROM painting GROUP BY a_id) AS tmp
      -> ON a.a_id = p.a_id AND p.price = tmp.max_price;
  ```

***

## Joining Tables from Different Databases

* To perform a join between tables located in different databases, qualify table and column names sufficiently that MySQL knows what you’re referring to.
* To indicate this, qualify each table name with a prefix that specifies which database it’s in. The fully qualified form of the join looks like this:

  ```sql
  mysql> SELECT a.name, p.title FROM db1.artist AS a INNER JOIN db2.painting AS p ON a.a_id = p.a_id;
  ```

