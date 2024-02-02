# <center>Window navigator properties</center>

* The `window.navigator` object contains information about the visitor's browser.
* The `window.navigator` object can be written without the window prefix.

* `cookieEnabled` property returns true if cookies are enabled, otherwise false
    
    ```javascript
    console.log(navigator.cookieEnabled);
    -> true
    ```

* ``appName`` property returns the application name of the browser
    
    ```javascript
    console.log(navigator.appName);
    -> Netscape     // "Netscape" is the application name for both IE11, Chrome, Firefox, and Safari.
    ```

* ``appCodeName`` property returns the application code name of the browser
  
  ```javascript
  console.log(navigator.appCodeName);
  -> Mozilla          // "Mozilla" is the application code name for both Chrome, Firefox, IE, Safari, and Opera.
  ```

* ``product`` property returns the product name of the browser engine
  
  ```javascript
  console.log(navigator.product);
  -> Gecko          // Most browsers returns "Gecko" as product name !!
  ```

* ``appVersion`` property returns version information about the browser
  
  ```javascript
  console.log(navigator.appVersion);
  -> 5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36
  ```

* ``userAgent`` property returns the user-agent header sent by the browser to the server
  
  ```javascript
  console.log(navigator.appVersion);
  -> "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36"
  ```

* ``platform`` property returns the browser platform (operating system)
  
  ```javascript
  console.log(navigator.platform);
  -> "Win32"
  ```
  
* ``language`` property returns the browser's language
  
  ```javascript
  console.log(navigator.language);
  -> "fr-FR"
  ```

* ``onLine`` property returns true if the browser is online
  
  ```javascript
  console.log(navigator.onLine);
  -> true
  ```
  
* ``javaEnabled()`` method returns true if Java is enabled
  
  ```javascript
  console.log(navigator.javaEnabled());
  -> false
  ```