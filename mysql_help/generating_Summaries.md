# <center>Generating Summaries</center>

## Basic Summary Techniques

* Use the appropriate aggregate function to summarize values, `DISTINCT` to select unique values, or `COUNT(DISTINCT)` to count unique values.

### Summarizing with `COUNT()`

  ```sql
  mysql> SELECT COUNT(*) FROM driver_log;
  ```
* `COUNT(*)` with no `WHERE` clause performs a full table scan.
* `MyISAM`: this is very quick.
* `InnoDB`: You may want to avoid it because it can be slow for large tables, 
  - If an approximate row count is good enough, avoid a full scan by extracting:
    ```sql
    mysql> SELECT TABLES_ROWS FROM INFORMATION_SCHEMA.TABLES
        -> WHERE TABLE_SCHEMA = 'db_name' AND TABLE_NAME = 'table_name';
    ```

* To count only the number of rows tha match certain condition, include an appropriate `WHERE` clause.

  ```sql
  mysql> SELECT COUNT(*) FROM driver_log WHERE miles > 200;
  mysql> SELECT COUNT(*) FROM states WHERE statehood BETWEEN '1800-01-01' AND '1899-12-31';
  mysql> SELECT
      -> COUNT(IF(DAYOFWEEK(trav_date)=7,1,NULL)) AS 'Saturday trips',
      -> COUNT(IF(DAYOFWEEK(trav_date)=1,1,NULL)) AS 'Sunday trips'
      -> FROM driver_log;
  ```

### Summarizing with `MIN()` and `MAX()`

* Finding smallest or largest values in a datases is somewhat akin to sorting.
* This operation applies to questions about smallest, largest oldest, newest, most expensive, least expensive.

  ```sql
  -- Whate date range is represented by the rows in the mail table? What are the smallest and largest messages sent?
  mysql> SELECT MIN(t) AS earliest, MAX(t) AS latest,             -- t DATETIME
      -> MIN(size) AS smallest, MAX(size) AS largest FROM mail;

  -- What are the smallest and largest US state population?
  mysql> SELECT MIN(pop) AS 'Fewest people', MAX(pop) AS 'Most people' FROM states;

  -- Whate are the first and last state names, lexically speaking? The shortest and longest names?
  mysql> SELECT
      -> MIN(name) AS First, MAX (name) AS Last,
      -> MIN(CHAR_LENGTH(name)) AS Shortest, MAX(CHAR_LENGTH(name)) AS Longest FROM states;
  ```

### Summarizing with `SUM()` and `AVG()`

* `SUM()` and `AVG()` produce the total and average (mean) of a set of values:
  ```sql
  -- Total amount of mail traffic in bytes and the average size of each message
  mysql> SELECT SUM(size) AS 'Total traffic',
      -> AVG(size) AS 'Average message size' FROM mail;

  -- How many miles did the drivers in the dreiver_log table and what was the average number of miles traveled per days
  mysql> SELECT SUM(miles) AS 'Total miles',
      -> AVG(miles) AS 'Average miles/day' FROM driver_log;

  -- Total population of the united states
  mysql> SELECT SUM(pop) FROM states;
  ```

* `SUM()` and `AVG()` are numeric functions, so they can’t be used with strings or temporal values. 
* But sometimes you can convert non numeric values to useful numeric forms.  
* Suppose that a table stores TIME values that represent elapsed time

  ```sql
  mysql> SELECT SUM(TIME_TO_SEC(t1)) AS 'Total seconds',
      -> SEC_TO_TIME(SUM(TIME_TO_SEC(t1))) AS 'Total time' FROM time_val;
  ```

### Using `DISTINCT` to eliminate duplicates

* A summary operation that uses no aggregate functions is determining the unique values or rows in a dataset. 
* Do this with `DISTINCT` (or `DISTINCTROW` , a synonym). 
* `DISTINCT` boils down a query result, and often is combined with `ORDER BY` to place values in more meaningful order.
  ```sql
  mysql> SELECT DISTINCT name FROM driver_log ORDER BY name;
  mysql> SELECT COUNT(DISTINCT name) FROM driver_log;     -- Determine the number of different drivers
  ```

### Finding Values Associated with Minimum and Maximum Values

* Aggregate function such as `MIN()` and `MAX()` cannot be used in `WHERE` clauses.
* To solve this problem, save the value in a user-defined variable.

  ```sql
  mysql> SET @max = (SELECT MAX(pop) FROM states);
  mysql> SELECT pop AS 'Highest population', name FROM states WHERE pop = @max;
      -> 37253956 | California
  ```

* Alternatively, for a single-statement solution, use a subquery in the `WHERE` clause that return a value

  ```sql
  mysql> SELECT pop AS 'Highest population', name FROM states WHERE 
      -> pop = (SELECT MAX(pop) FROM states);
      -> 37253956 | California

  mysql> SELECT bname, cnum, vnum, vtext FROM kjv
      -> WHERE CHAR_LENGTH(vtext) = (SELECT MIN(CHAR_LENGTH(vtext)) FROM kjv);
  ```

* Yet another way to select other columns from rows containing a minimum or maximum value is to use a join.
* Select the value into another table, then join it to the original table to select row that matches the value.

  ```sql
  mysql> CREATE TEMPORARY TABLE tmp SELECT MAX(pop) AS maxpop FROM states;
  mysql> SELECT states.*, tmp.maxpop FROM states  INNER JOIN tmp ON states.pop = tmp.maxpop;
  ```

### Dividing a Summary into Subgroups

* To arrange a set of rows into subgroups and summarize each group, use aggregate functions in conjunction with a `GROUP BY` clause
  ```sql
  -- Number of messages per sender
  mysql> SELECT srcuser, COUNT(*) FROM mail GROUP BY srcuser;

  -- For each sender, the total amount of traffic sent and the average number of bytes per message
  mysql> SELECT srcuser, SUM(size) AS 'Total bytes', AVG(size) AS 'Bytes per message' FROM mail GROUP BY srcuser;

  -- Find out how many messages each sender sent from each host
  mysql> SELECT srcuser, srchost, COUNT(srcuser) FROM mail GROUP BY srcuser, srchost;

  -- displaying for each the size of the largest message sent and the date of the most recent message
  mysql> SELECT srcuser, MAX(size), MIN(t) FROM mail GROUP BY srcuser;

  --  finds the size of the largest message sent between each pair of sender and recipient values
  mysql> SELECT srcuser, dstuser, MAX(size) FROM mail GROUP BY srcuser, dstuser;
  ```

### Summaries and NULL Values

* Most aggregate functions ignore `NULL` values. 
  - `COUNT()` is different: `COUNT(expr)` ignores `NULL` instances of expr, but `COUNT(*)` counts rows, regardless of content.
* By ignoring `NULL` values, aggregate functions become a lot more convenient.
* If you don’t want an aggregate value of `NULL` to display as `NULL`, use `IFNULL()` to map it appropriately

  ```sql
  mysql> SELECT subject,
      -> COUNT(score) AS n,
      -> IFNULL(SUM(score),0) AS total,
      -> IFNULL(AVG(score),0) AS average,
      -> IFNULL(MIN(score),'Unknown') AS lowest,
      -> IFNULL(MAX(score),'Unknown') AS highest
      -> FROM expt WHERE score IS NULL GROUP BY subject;
      
  --  The different forms of COUNT() can be very useful for counting missing values.
  mysql> SELECT COUNT(*) - COUNT(score) AS 'Missing' FROM expt;
  
  -- Missing and non missing counts can be determined for subgroups as well.
  mysql> SELECT subject,
      -> COUNT(*) AS total,
      -> COUNT(score) AS 'non missing',
      -> COUNT(*) - COUNT(score) AS missing FROM expt GROUP BY subject;
  ```

### Selecting Only Groups with Certain Characteristics

* `HAVING` operates on the already-selected-and-grouped set of rows, applying additional constraints based on aggregate function results that aren’t known during the initial selection process. 

  ```sql
  --  Identify drivers in the driver_log table who drove more than three days
  mysql> SELECT COUNT(*), name FROM driver_log GROUP BY name HAVING COUNT(*) > 3;
  
  -- HAVING can refer to aliases
  mysql> SELECT COUNT(*) AS count, name FROM driver_log GROUP BY name HAVING count > 3;
  ```
  
### Using Counts to Determine Whether Values Are Unique

* You can use `HAVING` to find unique values in situations to which `DISTINCT` does not apply. 
* `HAVING` can tell you which values were unique or nonunique

```sql
-- The days on which only one driver was active
mysql> SELECT trav_date, COUNT(trav_date) FROM driver_log GROUP BY trav_date HAVING COUNT(trav_date) = 1;

-- The days on which more than one driver was active.
mysql> SELECT trav_date, COUNT(trav_date) FROM driver_log GROUP BY trav_date HAVING COUNT(trav_date) > 1;
```

### Finding Smallest or Largest Summary Values

* `MIN()` and `MAX()` find the values at the endpoints of a set of values, but to find the endpoints of a set of summary values, those functions won’t work. 
* Their argument cannot be another aggregate function.

  ```sql
  mysql> SELECT name, SUM(miles) FROM driver_log GROUP BY name;
  mysql> SELECT name, SUM(miles) AS 'Largest SUM' FROM driver_log GROUP BY name ORDER BY SUM(miles) DESC LIMIT 1;
  mysql> SELECT name, SUM(miles) AS 'Smallest SUM' FROM driver_log GROUP BY name ORDER BY SUM(miles) LIMIT 1;
  ```

### Date-Based Summaries

* To sort rows temporally, use ORDER BY with a temporal column. To summarize rows instead, based on groupings into time intervals, determine how to categorize rows into the proper intervals and use `GROUP BY` to group them accordingly.

```sql

mysql> SELECT YEAR(trav_date) AS year, MONTH(trav_date) AS month,
    -> COUNT(*) AS 'number of drivers', SUM(miles) As 'miles logged'
    -> FROM driver_log GROUP BY year, month;
```
