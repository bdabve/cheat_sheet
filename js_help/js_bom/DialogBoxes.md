# <center>Dialog Boxes</center>

* `alert()`: displays a message to the user and waits for the user to dismiss the dialog.

* `confirm()`: displays a message, waits for the user to click an OK or Cancel button and returns a boolean value. 
 
* `prompt()`: displays a message, waits for the user to enter a string, and returns that string.

  ```javascript
  prompt('What is your name?', 'Example: dabve');
  ```
  
* Example of three Methods:
  
  ```javascript
  do {
   var name = prompt("What is your name?"); // Get a string
   var correct = confirm("You entered '" + name + "'.\n" + "Click Okay to proceed or Cancel to re-enter."); // Get a boolean
  } while(!correct) alert("Hello, " + name); // Display a plain message
  ```

  