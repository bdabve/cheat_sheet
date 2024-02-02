* To obtain the list of tables in a database

```sql
-- To obtain the list of tables in a database
mysql-> SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'cookbook';

-- To obtain a list of tables in the default database:
mysql-> SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE();

```

### Using information_schema to get table structure

```sql
--  Obtain information about a single column
mysql> SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'item'
    -> AND COLUMN_NAME = 'colors'\G
    
-- Obtain information about all columns
mysql> SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS
    -> WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'item';

-- Using show 
mysql> SHOW COLUMNS FROM item LIKE 'colors'\G
```

* Here are some COLUMNS table columns likely to be of most use:
  * `COLUMN_NAME`: The column name.
  * `ORDINAL_POSITION`: The position of the column within the table definition.
  * `COLUMN_DEFAULT`: The column’s default value.
  * `IS_NULLABLE`: YES or NO to indicate whether the column can contain NULL values.
  * `DATA_TYPE`,` COLUMN_TYPE`: Data type information. DATA_TYPE is the data-type keyword and COLUMN_TYPE contains additional information such as type attributes.
  * `CHARACTER_SET_NAME`, `COLLATION_NAME`: The character set and collation for string columns. They are NULL for nonstring columns.
  * `COLUMN_KEY`: Information about whether the column is indexed.