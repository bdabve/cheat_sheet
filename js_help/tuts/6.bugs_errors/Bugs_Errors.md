# <center>Error Handling</center>

## Strict mode

* JavaScript can be made a little stricter by enabling `strict mode`. This is done by putting the string `"use strict"` at the top of a file or a function body. 

    ```javascript
    function canYouSpotTheProblem() {
        "use strict";
        for (counter = 0; counter < 10; counter++) {
        console.log("Happy happy");
        }
    }
    canYouSpotTheProblem();
    // → Uncaught ReferenceError: counter is not defined
    ```
    > Normally, when you forget to put let in front of your binding, as with counter in the example, JavaScript quietly creates a global binding and uses that. In `strict mode`, an error is reported instead.

* Strict mode does a few more things. It disallows giving a function multiple parameters with the same name and removes certain problematic language features entirely.

* putting `"use strict"` at the top of your program rarely hurts and might help you spot a problem.

## Types

* A lot of mistakes come from being confused about the kind of value that goes into or comes out of a function. If you have that information written down, you’re less likely to get confused. You could add a comment like the following before the `goalOrientedRobot`
    
    ```javascript
    // (VillageState, Array) → {direction: string, memory: Array}
    function goalOrientedRobot(state, memory) {
    // ...
    }
    ```

## Testing

## Exceptions

* When a function cannot proceed normally, what we would like to do is just stop what we are doing and immediately jump to a place that knows how to handle the problem. This is what exception handling does.

    ```javascript
    function promptDirection(question) {
        let result = prompt(question);
        if (result.toLowerCase() == "left") return "L";
        if (result.toLowerCase() == "right") return "R";
        throw new Error("Invalid direction: " + result);
    }
    function look() {
        if (promptDirection("Which way?") == "L") {
            return "a house";
        } else {
            return "two angry bears";
        }
    }
    try {
        console.log("You see", look());
    } catch (error) {
        console.log("Something went wrong: " + error);
    }
    ```
    * The `throw` keyword is used to raise an exception.
    * In this case, we used the `Error` constructor to create our exception value.

* The `try` and `catch` keywords are more standard and more flexible than the onerror technique

  ```javascript
  try
  {
      request = new XMLHTTPRequest()
  }
  catch(err)
  {
      // Use a different method to create an XML HTTP Request object
  }
  finaly
  {
      // that is  always  executed,  regardless  of  whether  an  error occurs  in  the  try clause.
  }
  ```

## Using the onerror event

```javascript
onerror = errorHandler
document.writ("Welcome to this website") // Deliberate error
function errorHandler(message, url, line)
{
    out  = "Sorry, an error was encountered.\n\n";
    out += "Error: " + message + "\n";
    out += "URL: "   + url     + "\n";
    out += "Line: "  + line    + "\n\n";
    out += "Click OK to continue.\n\n";
    alert(out);
    return true;
}
```

## Assertions

* `Assertions` are checks inside a program that verify that something is the way it is supposed to be. They are used not to handle situations that can come up in normal operation but to find programmer mistakes.

  ```javascript
  function firstElement(array) {
    if (array.length == 0) {
      throw new Error("firstElement called with []");
    }
  return array[0];
  }
  ```
  
  * Now, instead of silently returning undefined (which you get when reading an array property that does not exist), this will loudly blow up your program as soon as you misuse it. This makes it less likely for such mistakes to go unnoticed and easier to find their cause when they occur.