## Opening and Closing Windows

* `window.open()` method of the Window object open a new web browser window (or tab; this is usually a browser configuration option). 
* `Window.open()`: loads a specified URL into a new or existing window and returns the Window object that represents that window. It takes four optional arguments:
  1. URL of the document to display in the new window. If this argument is omitted (or is the empty string), the special blank-page URL
about:blank is used.
  2. is a string that specifies a window name. If a window by that name already exists (and if the script is allowed to navigate that window), that existing window is used. Otherwise a new window is created and is assigned the specifiedname. If this argument is omitted, the special name “_blank” is used: it opens a new, unnamed window.
    > Note that scripts cannot simply guess window names and take over the windows in use by other web applications: they can only name existing windows that they are “allowed to navigate” (the term is from the HTML5 specification). Loosely, a script can specifyan existing window by name only if that window contains a document from the same origin or if the script opened that window (or recursively opened a window that opened that window). Also, if one window is a frame nested within the other, a script in either one can navigate the other. In this case, the reserved names “_top” (the top-level ancestor window) and “_parent” (the immediate parent window) can be useful.
  3. Is a comma-separated list of size and features attributes for the new window to be opened. If you omit this argument, the new windowis given a default size and has a full set of UI components.
    
    ```javascript
    var w = window.open("smallwin.html", "smallwin", "width=400,height=350,status=yes,resizable=yes");
    ```

  4. This fourth argument is a boolean value that indicates whether the URL specified as the first argument should replace the current entry in the window’s browsing history (true) or create a new entry in the window’s browsing history (false). Omitting this argument is the same as passing false.
  
* The return value of the `open()` method is the Window object that represents the named or newly created window. 
* You can use this Window object in your JavaScript code to refer to the new window, just as you use the implicit Window object window to refer to the window within which your code is running:
  
  ```javascript
  var w = window.open();                            // Open a new, blank window.
  w.alert("About to visit http://example.com");     // Call its alert() method
  w.location = "http://example.com";                // Set its location property
  ```
* In windows created with the `window.open()` method, the opener property refers back to the Window object of the script that opened it. In other windows, opener is null:
  ```javascript
  w.opener !== null; // True for any window w created by open()
  w.open().opener === w; // True for any window w
  ```
### Examples

```javascript
var openButton = document.getElementById('open');
        openButton.onclick = function() {
            window.open('', '', '', '');                // Open an empty tab with name 'about:blank'     
        }
var openButton = document.getElementById('open');
        openButton.onclick = function() {
            window.open('https://www.google.com', '', '', '');                // Open google in new tab     
        }
var openButton = document.getElementById('open');
        openButton.onclick = function() {
            window.open('https://www.google.com', '_blank', '', '');     // Open in new tab (_self: erase existing window)     
        }
var openButton = document.getElementById('open');
        openButton.onclick = function() {
            window.open('https://www.google.com', '_blank', 'width=400, height=400, left=400, menubar=no', '');      
        }
var openButton = document.getElementById('open');
        openButton.onclick = function() {
            window.open('https://www.google.com', '_blank', 'width=400, height=400, left=400, menubar=no', 'true');
                                         // Replace in history list
        }
```

## Closing windows

* Just as the `open()` method opens a new window, the `close()` method closes one. 
* If you create a Window object w, you can close it with: `w.close();`
* JavaScript code running within that window itself can close it with: `window.close();`
* Most browsers allow you to automatically close only those windows that your own JavaScript code has created. If you attempt to close any other window, the request either fails or the user is presented with a dialog box that asks him to allow (or cancel)
that request to close the window. 

* [Open Method Example](./html/window_open.html)