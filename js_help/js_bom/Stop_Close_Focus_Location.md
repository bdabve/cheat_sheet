## Stop

* The `stop()` method stops window loading.

* This method is the same as clicking on the browser's stop button.

* This method may be useful if the loading of an image or frame takes too long.

```javascript
window.stop();
```

## Close

* Close window or tabs
  
  ```javascript
  var myTab = window.open('', '', '', '');
  myTab.close();
  ```
  
## Focus

```javascript
var myTab = window.open('', '', '', '');
myTab.focus();
```

---
## Location

* The `location` object contains information about the current URL.
* The location object is part of the window object and is accessed through the window.location property.

### Location.href

* The `href` property sets or returns the entire URL of the current page.

  ```javascript
  location.href;        // Get location of the window ex:www.google.com
  location.href = 'https://www.google.com'  // Set location
  location.href = 'info.php'        // local host address
  location.href = '#top'            // An Anchor within the page
  location.href = 'mailto:someone@example.com'  // Specifies a different protocol (mail, file, ftp)
  ```

### Location.hash

* The `hash` property sets or returns the anchor part of a URL, including the hash sign (#).
 
  ```javascript
  location.href = 'http://www.example.com/test.htm#part2';
  location.hash;    // output: #part2

  // set anchor to par5 without "#"
  location.hash = "part5";
  ```

### Location.host

* The `host` property sets or returns the hostname and port of a URL.

  ```javascript
  location.host;
  location.host = hostname:port;
  ```
  
### Location.protocol

* The `protocol` property sets or returns the protocol of the current URL, including the colon (:).
* The `protocol` is a standard that specifies how data are transmitted between computers.

  ```javascript
  location.protocol;    // file:, ftp:, http:, https:, mailto:, etc..

  location.protocol = 'https';
  ```
  
### Location.search

* The `search` property sets or returns the querystring part of a URL, including the question mark (?).

* The querystring part is the part of the URL after the question mark (?). This is often used for parameter passing.

  ```javascript
  location.search;

  location.search = '?email=someone@example.com';
  ```

### Location.pathname

* The `pathname` property sets or returns the pathname of a URL.

  ```javascript
  location.pathname;

  location.pathname = '/var/www/html/info.php';
  ```

### Location.assign(), Location.replace(), Location.reload()

* The `assign()` method loads a new document.
* The `replace()` method replaces the current document with a new one.
  > The difference between `assign()` and `replace()`, is that `replace()` removes the URL of the current document from the history.
* The `reload()` method is used to reload the current document. does the same as the reload button in your browser.

  ```javascript
  location.assign('https://www.google.com');

  location.replace('https://www.youtube.com');

  location.reload();
  ```