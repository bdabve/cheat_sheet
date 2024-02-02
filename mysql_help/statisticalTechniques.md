## <center>Statistical Techniques</center>


* Many common descriptive statistics, such as mean and standard deviation, are obtained by applying aggregate functions to your data. Others, such as median or mode, are calculated based on counting queries.

  ```sql
  mysql> SELECT COUNT(score) AS n, SUM(score) AS sum, AVG(score) AS mean,
      -> MIN(score) AS minimum, MAX(score) AS maximum,
      -> STDDEV_SAMP(score) AS 'std. dev.', VAR_SAMP(score) AS 'variance' FROM testscore;
  ```

* Use aggregate functions, but employ a `GROUP BY` clause to arrange observations into the appropriate groups.

  ```sql
  -- Group by age
  mysql> SELECT age, COUNT(score) AS n,
      -> SUM(score) AS sum, AVG(score) AS mean,
      -> MIN(score) AS minimum, MAX(score) AS maximum FROM testscore GROUP BY age;

  -- Group by sex
  mysql> SELECT age, COUNT(score) AS n,
      -> SUM(score) AS sum, AVG(score) AS mean,
      -> MIN(score) AS minimum, MAX(score) AS maximum FROM testscore GROUP BY sex;

  -- Group by age and sex
  mysql> SELECT age, COUNT(score) AS n,
      -> SUM(score) AS sum, AVG(score) AS mean,
      -> MIN(score) AS minimum, MAX(score) AS maximum FROM testscore GROUP BY age, sex;
  ```

* A common application for per-group summary techniques is to generate a frequency distribution that shows how often each value occurs.

  ```sql
  mysql> SELECT score, COUNT(score) AS counts FROM testscore GROUP BY score;
  
  --  To display an ASCII bar chart of the test score counts, convert the counts to strings of * characters:
  mysql> SELECT score, REPEAT('*',COUNT(score)) AS 'count histogram' FROM testscore GROUP BY score;
  
  -- To chart the relative frequency distribution instead, use the percentage values:
  mysql> SET @n = (SELECT COUNT(score) FROM testscore);
  mysql> SELECT score, REPEAT('*',(COUNT(score)*100)/@n) AS 'percent histogram' FROM testscore GROUP BY score;
  ```
  
* Count the number of `NULL` values in the set.

  ```sql
  mysql> SELECT COUNT(*) as 'Total', COUNT(score) as 'Non Missing', COUNT(*) - COUNT(score) as 'Missing' FROM t;

  -- Using SUM(ISNULL(score)). 
  -- The ISNULL() function returns 1 if its argument is NULL, zero otherwise:
  mysql> SELECT COUNT(*) AS 'Total', COUNT(score) AS 'Non Missing', SUM(ISNULL(score)) AS 'Missing' FROM t;
  ```
  
* MySQL has a RAND() function that produces random numbers between 0 and 1
  
  ```sql
  mysql> SELECT RAND(), RAND(i);
  ```