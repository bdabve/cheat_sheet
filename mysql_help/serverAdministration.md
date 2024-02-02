# <center>Server Administration</center>

### Configuring the Server

* The MySQL server places many configuration parameters under your control. 
* For example, resources that require memory can be adjusted up or down to tailor resource usage. 
* A heavily used server requires more memory; a lightly used one, less. 
* You can set command options and system variables at server startup, and many system variablesare settable at runtime as well. 
* You can also examine your settings at runtime to verify that the configuration is as you intend.

#### Configuration control at server startup

* To configure the server at startup time, specify options on the command line or in an option file. 

  ```bash
  [mysqld]
  character_set_server=utf8     # Set character set to utf8
  sql_mode=TRADITIONAL          # The default SQL mode is NO_ENGINE_SUBSTITUTION
  event_scheduler=1             # The event scheduler is disabled by default. 
  innodb_buffer_pool_size=256M  # Increase the InnoDB buffer pool size from its default of 128MB.
  ```
  
#### Configuration control and verification at runtime

* After the server starts, you can make runtime adjustments by changing system variables using the `SET` statement

  ```sql
  SET GLOBAL var_name = value;
  ```

* A DBA with the `SUPER` privilege can change the global value at runtime
  ```sql
  SET GLOBAL sort_buffer_size = 1024 * 256;
  ```

* Each client has its session variable initialized to the same value, but can change the value as it likes.

  ```sql
  SET SESSION sort_buffer_size = 1024 * 1024;
  ```
  
* There is alternative syntax for writing system variable references
* The @@ syntax is more flexible. It can be used in statements other than SET, enabling you to retrieve or examine individual system variables
* References to system variables using `@@` syntax with no `GLOBAL`. or `SESSION`. modifier access the session value if there is one, or the global value otherwise.

  ```sql
  SET @@GLOBAL.var_name = value;
  SET @@SESSION.var_name = value;

  mysql> SELECT @@GLOBAL.secure_auth, @@SESSION.sql_mode;
  ```

* Other ways to access system variables include the `SHOW VARIABLES` statement and selecting from the `INFORMATION_SCHEMA GLOBAL_VARIABLES` and `SESSION_VARIABLES` tables.

### Managing the Plug-In Interface

* MySQL supports the use of plug-ins that extend server capabilities.
* If you don’t know the name of a given plug-in file, look in the directory named by the plugin_dir system variable, which is where the server expects to find plug-in files.

  ```sql
  mysql> SELECT @@plugin_dir;
  mysql> SHOW PLUGINS;          -- To see which plug-in are installed, or query INFORMATION_SCHEMA PLUGINS
  ```

* To install a plug-in only for a given server invocation, use the `--plugin-load-add` option at server startup, naming the file that contains the plug-in.

  ```bash
  [mysqld]
  plugin-load-add=validate_password.so    # On windows .dll
  plugin-load-add=adt_null.so
  #plugin-load-add=semisync_master.so
  #plugin-load-add=semisync_slave.so
  ```

* To install a plugin at runtime and make it persistent, use `INSTALL PLUGIN`. 

  ```sql
  INSTALL PLUGIN validate_password SONAME 'validate_password.so';  -- The SONAME (“shared object name”), specifies the file that contains the plug-in.
  
  UNINSTALL PLUGIN validate_password;   -- To disable a plug-in at runtime
  ```

### Controlling Server Logging 

#### The error log

* The error log contains information about problems or exceptional conditions the server encounters. 
* This is useful information for debugging. 
* In particular, if the server exits, check the error log for the reason. 
* For example, if an exit occurs immediately after startup, it’s likely that some setting in the server option file is misspelled or was set to an invalid value. The error log will contain a message to that effect.

* The error log cannot be disabled, but you can control where it’s written. 
* By default, on Unix, the error output goes to your terminal on Unix or to host_name.err in the data directory if you start the server using `mysqld_safe`.

  ```bash
  # Write the error log to the err.log file in the data directory:
  [mysqld]
  log_error=err.log
  # As of MySQL 5.7.2, you can influence the amount of error log output by setting the log_error_verbosity system variable. Permitted values range from 1 (errors only) to 3 (errors, warnings, notes; the default). To see errors only, do this:
  [mysqld]
  log_error=err.log
  log_error_verbosity=1
  # On Unix, if you start the server using mysqld_safe, it’s possible to redirect the error log to the syslog facility:
  [mysqld_safe]
  syslog
  ```

#### The general query and slow query logs

* The slow query log records statements that took a long time to execute
* Several system variables control the general query and slow query logs. 
* Each variable can be set at server startup or changed at runtime:
  * `log_output` controls the log destinations. The value is `FILE` (log to files, the default), `TABLE` (log to tables), `NONE` (disable logging), or a comma-separated combination of values, in any order. NONE overrides any other value. If the value is `NONE`, other settings for these logs have no effect. Destination control applies to the general query and slow query logs together; you cannot write one to a file and the other to a table.
  
  * `general_log` and `slow_query_log` enable or disable the respective logs. By default, each log is disabled. If you enable either of them, the server writes the log to the destinations specified by `log_output`, unless that variable is NONE.
  
  * `general_log_file` and `slow_query_log_file` specify log filenames. The default names are `host_name.log` and `host_name-slow.log`; however, these settings have no effect unless `log_output` specifies `FILE` logging.

  ```bash
  # Write the general query log to the query.log file in the data directory:
  [mysqld]
  log_output=FILE
  general_log=1
  general_log_file=query.log
  # Write the general and slow query logs to tables in the mysql database (the table names are general_log and slow_log and cannot be changed):
  [mysqld]
  log_output=TABLE
  general_log=1
  slow_query_log=1
  # Write the general query log to a file named query.log and to the general_log table:
  [mysqld]
  log_output=FILE,TABLE
  general_log=1
  general_log_file=query.log
  ```

#### The binary log

* The binary log contains a record of data changes made by the server. 
* To set up replication, you must enable the binary log on the master server: it serves as the storage medium for changes to be sent to slave servers. The binary log is also used, together with backup files, during data recovery operations.

* To enable the binary log, use the `--log-bin` option, optionally specifying the logfile basename as the option value. 
* The default basename is `host_name-bin`. 
* The value for this option is a basename because the server creates binary logfiles in numbered sequence, automatically adding to the basename suffixes of .000001, .000002, and so forth.
* The server advances to the next file in the sequence when it starts, when the logs are flushed, and when the current file reaches the maximum logfile size (controlled by the `max_binlog_size` system variable). 
* To have the server expire logfiles for you, set the `expire_logs_days` system variable to the age in days at which files become eligible for removal.

  ```bash
  # Enable the binary log, writing numbered files in the data directory having names beginning with host_name-bin:
  [mysqld]
  log-bin
  # Enable the binary log, writing numbered files in the data directory having names beginning with binlog. Additionally, expire logfiles after a week:
  [mysqld]
  log-bin=binlog
  max_binlog_size=4G
  expire_logs_days=7
  ```
#### Rotating or Expiring Logfiles

* Logfile rotation is a technique that renames a logfile through a series of one or more names.
* To flush the server logs, execute a `FLUSH LOGS` statement or use the mysqladmin flushlogs command.

  ```bash
  $ mv err.log err.log.old
  $ mysqladmin flush-logs

  # Multiple files
  $ mv query.log.2 query.log.3
  $ mv query.log.1 query.log.2
  $ mv query.log query.log.1
  $ mysqladmin flush-logs
  ```

* The server creates binary logfiles in numbered sequence. To expire them, you need only arrange that it removes files when they’re old enough.

  ```bash
  # The following settings enable the binary log, set the maximum file size to 4GB, and expire files after four days:

  [mysqld]
  log-bin=binlog
  max_binlog_size=4G
  expire_logs_days=4

  PURGE BINARY LOGS TO 'binlog.001028';
  ```
  
* Automating logfile rotation
  
  ```bash
  #!/bin/sh
  mv err.log err.log.old
  mysqladmin --defaults-file=/usr/local/mysql/data/flush-opts.cnf flush-logs
  ```

####  Rotating Log Tables or Expiring Log Table Rows

* To rotate a log table, rename it and open a new table with the original name.
* To expire log table contents, remove rows older than a certain age.
* To employ log table rotation, create an empty copy of the original table to serve as the new table, then rename the original table and rename the new one to take its place:

  ```sql
  DROP TABLE IF EXISTS mysql.general_log_old, mysql.general_log_new;
  CREATE TABLE mysql.general_log_new LIKE mysql.general_log;
  RENAME TABLE mysql.general_log TO mysql.general_log_old, mysql.general_log_new TO mysql.general_log;

  -- To empty a log table completely, truncate it:
  TRUNCATE TABLE mysql.general_log;

  -- To expire a table selectively, removing only rows older than a given age, you must know the name of the column that indicates row-creation time:
  DELETE FROM mysql.general_log WHERE event_time < NOW() - INTERVAL 1 WEEK;

  -- For automatic expiration, the statements for any of the techniques just described can be executed within a scheduled event (see Recipe 9.8). For example:
  CREATE EVENT expire_general_log ON SCHEDULE EVERY 1 WEEK DO 
  DELETE FROM mysql.general_log WHERE event_time < NOW() - INTERVAL 1 WEEK;
  ```


###  Monitoring the MySQL Server

#### Sources of monitoring information

* System variables tell you how the server is configured.
* Status variables provide information about operations the server is performing, such as number of statements executed, number of disk accesses, memory use, or cache efficiency
* `SHOW` statements and tables in the `INFORMATION_SCHEMA` database provide information ranging from processes running in the server to active storage engines and plug-ins to system and status variables. In many cases, these two sources provide the same or similar information, but in different display formats.
  
  * For interactive use, `SHOW` is often more convenient because it involves less typing than `INFORMATION_SCHEMA` queries.
  
    ```sql
    mysql> SHOW GLOBAL STATUS LIKE 'Threads_connected';
    mysql> SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME = 'Threads_connected';
    ```
    
  * `INFORMATION_SCHEMA` queries use `SELECT`, which is more expressive than `SHOW` and can be used for highly specific or complex queries, including joins.
    ```sql
    SET @queries = (SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME = 'Queries');
    ```
  * Some storage engines make information available about themselves. `InnoDB`, for example, has its own system and status variables. It also provides its own `INFORMATION_SCHEMA` tables and a set of `InnoDB` Monitors.
  
    ```sql
    SHOW TABLES FROM INFORMATION_SCHEMA LIKE 'innodb%';
    ```
* Is the server running? If so, how long has it been up? 

  ```bash
  $ mysqladmin ping
  $ mysqladmin status
  ```
  ```sql
  SHOW GLOBAL STATUS LIKE 'Uptime';
  ```
  
* If the server stops shortly after you start it, a likely cause is misconfiguration in the server option file. 
* The error log helps you here.
  ```
  check for [ERROR] lines, such as this:
  2014-03-01T03:36:48.756313Z 0 [ERROR] mysqld: Error while setting value 'TRADITONAL' to 'sql_mode'
  ```

* How many queries is my server processing? 
 
  ```sql
  mysql> SHOW GLOBAL STATUS LIKE 'Queries';
  mysql> SHOW GLOBAL STATUS LIKE 'Uptime';
  mysql> SELECT (65743031 * 60) / 22164600 AS 'statements/minute';  -- Here SELECT ('Queries'*60)/uptime

  SELECT @@wait_timeout;      -- To get the session timeout value (in seconds)
  -- The default value is 28,800 (8 hours). If it’s configured to a value shorter than your desired, set it higher:
  SET wait_timeout = seconds;

  --  This query summarizes number of statements per user, most active users first:
  SELECT COUNT(*), user_host FROM mysql.general_log GROUP BY user_host ORDER BY COUNT(*) DESC;

  -- Shows which statements appear most often in the slow query log:
  SELECT COUNT(*), sql_text FROM mysql.slow_log GROUP BY sql_text ORDER BY COUNT(*) DESC;
  ```

* Is my slave replication server communicating with the master, or has replication stopped? 
  ```sql
  -- Executing SHOW SLAVE STATUS on the slave provides columns showing the status of the I/O and SQL threads, and columns containing error information:
  mysql> SHOW SLAVE STATUS\G

  -- the Performance Schema replication_connection_status table provides information similar to that just shown
  mysql> SELECT * FROM performance_schema.replication_connection_status\G
  ```

* Are the key caches sized properly for efficient operation? 

  ```sql
  -- To determine the cache sizes, check the relevant system variables:
  mysql> SELECT @@innodb_buffer_pool_size, @@key_buffer_size;

  -- You can also use SHOW VARIABLES or the INFORMATION_SCHEMA GLOBAL_VARIABLES table.
  mysql> SELECT * FROM INFORMATION_SCHEMA.GLOBAL_VARIABLES WHERE VARIABLE_NAME 
      -> IN ('INNODB_BUFFER_POOL_SIZE','KEY_BUFFER_SIZE');
  ```

* The following SQL script uses that approach to fetch the relevant status variables into user-defined variables and compute the hit rates:
  
  ```sql
  -- hitrate.sql: Show InnoDB and MyISAM key cache hit rate statistics
  USE INFORMATION_SCHEMA;
  SET @reads = (SELECT VARIABLE_VALUE FROM GLOBAL_STATUS
   WHERE VARIABLE_NAME = 'INNODB_BUFFER_POOL_READS');
  SET @requests = (SELECT VARIABLE_VALUE FROM GLOBAL_STATUS
   WHERE VARIABLE_NAME = 'INNODB_BUFFER_POOL_READ_REQUESTS');
  SET @hit_rate = TRUNCATE(IFNULL(1 - (@reads/@requests), 0), 4);
  SELECT 'InnoDB key cache hit rate' AS Message,
   @reads, @requests, @hit_rate;
  SET @reads = (SELECT VARIABLE_VALUE FROM GLOBAL_STATUS
   WHERE VARIABLE_NAME = 'KEY_READS');
  SET @requests = (SELECT VARIABLE_VALUE FROM GLOBAL_STATUS
   WHERE VARIABLE_NAME = 'KEY_READ_REQUESTS');
  SET @hit_rate = TRUNCATE(IFNULL(1 - (@reads/@requests), 0), 4);
  SELECT 'MyISAM key cache hit rate' AS Message,
   @reads, @requests, @hit_rate;
  
  -- Invoke the script from cmdline
  $ mysql -t < hitrate.sql
  ```

*  The following queries retrieve similar information, but the column headings differ in lettercase and sometimes in name, and variable names differ in lettercase:

  ```sql
  mysql> SHOW GLOBAL STATUS;
  mysql> SELECT * FROM INFORMATION_SCHEMA.GLOBAL_STATUS;
  ```

