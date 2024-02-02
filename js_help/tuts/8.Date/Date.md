# <center>The Date class</center>

* JavaScript has a standard class for representing dates—or, rather, points in time. It is called Date. If you simply create a date object using `new`, you get the current date and time.

  ```javascript
  console.log(new Date());
  // → Wed Oct 31 2018 11:39:27 GMT+0100 (heure normale d’Europe centrale)
  ```

* You can also create an object for a specific time.

  ```javascript
  console.log(new Date(2009, 11, 9));
  // → Wed Dec 09 2009 00:00:00 GMT+0100 (CET)
  console.log(new Date(2009, 11, 9, 12, 59, 59, 999));
  // → Wed Dec 09 2009 12:59:59 GMT+0100 (CET)
  ```

* JavaScript uses a convention where month numbers start at zero (so December is 11), yet day numbers start at one. This is confusing and silly. Be careful.
* The last four arguments (hours, minutes, seconds, and milliseconds) are optional and taken to be zero when not given.
* Timestamps are stored as the number of milliseconds since the start of 1970, in the UTC time zone. This follows a convention set by "Unix time", which was invented around that time.
* You can use negative numbers for times before 1970. 
* The `getTime` method on a date object returns this number. It is big, as you can imagine.

  ```javascript
  console.log(new Date(2013, 11, 19).getTime());
  // → 1387407600000
  console.log(new Date(1387407600000));
  // → Thu Dec 19 2013 00:00:00 GMT+0100 (CET)
  ```

* If you give the Date constructor a single argument, that argument is treated as such a millisecond count. 
* You can get the current millisecond count by creating a new Date object and calling getTime on it or by calling the `Date.now` function.
* Date objects provide methods such as 
  * ``getFullYear``
  * ``getMonth``
  * ``getDate``
  * ``getHours``
  * ``getMinutes``
  * ``getSeconds`` 
  * ``getFullYear``
  * ``getYear`` : which gives you the year minus 1900 (98 or 119) and is mostly useless.

