# <center>Timers</center>

## setTimeout()

* The `setTimeout()` method of the Window object schedules a function to run after a specified number of milliseconds elapses. `setTimeout()` returns a value that can be passed to `clearTimeout()` to cancel the execution of the scheduled function.

  ```javascript
  // Wait 2 seconds and then say hello
  setTimeout(function() { alert("hello world"); }, 2000);
  
  // Another syntax
  function sayHello(){
    'use strict';    
    alert("Hello World!");
  }
  
  setTimeout(sayHello, 2000);
  ```
* [setTimeout Example](./html/setTimeOut.html)


### With jQuery

```
var doHomeworkAlarm = function () {
 alert("Hey! You need to do your homework!");
};
var timeoutId = setTimeout(doHomeworkAlarm, 60000);

clearTimeout(timeoutId);
```

## setInterval()

* The `setInterval()` is like `setTimeout()` except that the specified function is invoked repeatedly at intervals of the specified number of milliseconds. `setInterval()` returns a value that can be passed to `clearInterval()` to cancel any future invocations of the scheduled function.

  ```javascript
  setInterval(function(){      
      location.reload();      // Reload a web page      
  }, 5000);   // Reload a web page every 5 seconds

  var counter = 1;
  var printMessage = function () {
   console.log("You have been staring at your console for " + counter  + " seconds");
   counter++;
  };
  var intervalId = setInterval(printMessage, 1000);
  clearInterval(intervalId);
  ```

* Make a counter:

```javascript
$(function () {
  "use strict";

  setInterval(function (){
      var count = parseInt($('#countDown').html());
      if ( count > 0) {
          $('#countDown').html(count - 1);
      } else if (count == 0){
          $('.title').html('Redirecting ...');
          window.location = 'https://www.google.com';
      }
  }, 1000);

});
```
* [setInterval Example](./html/setInterval.html)
* [Count Down](../jquery/tutorials/html/countDown.html)
* [Move Element With jQuery](../jquery/tutorials/html/moveElementSetInterval.html)