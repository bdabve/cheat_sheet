# <center>Sorting Query Result </center>


## ORDER BY

```sql
mysql> SELECT * FROM driver_log ORDER BY name;  -- Single column sort
mysql> SELECT * FROM driver_log ORDER BY name ASC;  -- ASC : ascending sort; DESC: descending. 


mysql> SELECT * FROM driver_log ORDER BY name, trav_date;  -- Multiple column sort
mysql> SELECT * FROM driver_log ORDER BY name DESC, trav_date;  

mysql> SELECT name, trav_date, miles AS distance FROM driver_log ORDER BY distance; -- You can refer to the alias in the ORDER BY  
```

## Using Expressions for Sorting

* Put the expression that calculates the values in the ORDER BY clause.

```sql
mysql> SELECT t, srcuser, FLOOR((size+1023)/1024) AS kb FROM mail WHERE size > 50000 ORDER BY kb;

mysql> SELECT t, srcuser, CONCAT(FLOOR((size+1023)/1024), ' KB') AS kb FROM mail WHERE size > 50000 ORDER BY size;
```

## Date Sorting Based

```sql
mysql> SELECT * FROM mail WHERE srcuser = 'phil' ORDER BY t DESC;       -- Msg Most recently sent.
mysql> SELECT * FROM mail ORDER BY TIME(t);                             -- Sorting by TIME of day
mysql> SELECT * FROM occasion ORDER BY MONTH(date), DAYOFMONTH(date);   -- Sorting by calendar day
mysql> SELECT DAYNAME(date), date, description FROM occasion ORDER BY MOD(DAYOFWEEK(date)+5, 7);
mysql>
```

## Sorting by Fixed-Length Substrings

* For that kind of operation, functions such as `LEFT()`,`MID()`, and `RIGHT()` are useful to extract values components

```sql
mysql> SELECT * FROM housewares ORDER BY LEFT(id,3);
mysql> SELECT * FROM housewares ORDER BY MID(id,4,5);
mysql> SELECT * FROM housewares ORDER BY RIGHT(id,2), MID(id,4,5);
```

* Creating id

  ```sql
  mysql> SELECT category, serial, country,
      -> CONCAT(category,serial,country) AS id    -- Creating id from category, serial, country
      -> FROM housewares2 ORDER BY category, country, serial;
  ```
  
* Taking part of string

  ```sql
  mysql> SET @example = DIN40762US;
  mysql> SELECT @example, LEFT(SUBSTRING(@example,4),CHAR_LENGTH(SUBSTRING(@example,4)-2));
      -> DIN40762US | 40762
  ```
  
* `The SUBSTRING()` function takes an optional third argument specifying a desired result length

  ```sql
  mysql> SELECT @example, SUBSTRING(@example, 4, CHAR_LENGTH(@example) -5);
      -> DIN40762US | 40762
  mysql> SELECT * FROM housewares3 ORDER BY SUBSTRING(id,4,CHAR_LENGTH(id)-5);
  ```
  
  * One way is to add zero, which tells MySQL to perform a stringto-number conversion that results in a numeric sort of the serial number values
  
    ```sql
    mysql> SELECT * FROM housewares3 ORDER BY SUBSTRING(id,4,CHAR_LENGTH(id)-5)+0;
    ```
    
##  Defining a Custom Sort Order

* You can use `FIELD()` to sort an arbitrary set of values into any order you please.

  ```sql
  mysql> SELECT * FROM driver_log ORDER BY FIELD(name,'Henry','Suzi','Ben');
  ```
  
## Displaying One Set of Values While Sorting by Another

```sql
mysql> SELECT name, jersey_num FROM roster ORDER BY jersey_num+0;     -- To force numeric order

mysql> SELECT t, srcuser, CONCAT(FLOOR((size+1023)/1024),'K') AS size_in_K
    -> FROM mail WHERE size > 50000 ORDER BY size;
    
mysql> SELECT t, CONCAT(srcuser,'@',srchost) AS sender, size
    -> FROM mail WHERE size > 50000 ORDER BY srchost, srcuser;
    
mysql> SELECT CONCAT(first_name,' ',last_name) AS full_name
    -> FROM name ORDER BY last_name, first_name;
```
