# <center>JavaScript in Web Browsers</center>

## Client-Side JavaScript

* The `Window` object is the main entry point to all client-side JavaScript features and APIs. It represents a web browser window or frame, and you can refer to it with the identifier `window`. 
  
  ```javascript
  // Set the location property to navigate to a new web page
  window.location = "http://www.oreilly.com/";
  ```

* The ``Window`` object also defines methods like ``alert()``, which displays a message in a dialog box, and ``setTimeout()``, which registers a function to be invoked after a specified amount of time:
  
  ```javascript
  // Wait 2 seconds and then say hello
  setTimeout(function() { alert("hello world"); }, 2000);
  ```

* The ``Window`` object is also the global object. This means that the ``Window`` object is at the top of the scope chain and that its properties and methods are effectivelybglobal variables and global functions. 

* The ``Window`` object has a property named ``window`` that always refers to itself. You can use this property if you need to refer to the
``window`` object itself, but it is not usually necessary to use window if you just want to refer to access properties of the global window object.