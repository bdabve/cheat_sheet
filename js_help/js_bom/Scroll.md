## Scroll By

* The `scrollBy()` method scrolls the document by the specified number of pixels.
* Syntax: `scrollBy(x, y)` Numbers in pixels

  ```javascript
  var scrollButton = document.getElementById('scroll');
  scrollButton.onclick = function() {
        'use strict';
      window.scrollBy(200, 150);
      window.console.log('Window Scrolled left: ' + window.scrollX);
      window.console.log('Window Scrolled top: ' + window.scrollY);
  ```

## Scroll To

* The `scrollTo()` method scrolls the document to the specified coordinates.
* Syntax: `scrollTo(x, y)` Numbers in pixels

  ```javascript
  var scrollButton = document.getElementById('scroll');
  scrollButton.onclick = function() {
        'use strict';
      window.scrollTo(200, 150);
      window.console.log('Window Scrolled left: ' + window.scrollX);
      window.console.log('Window Scrolled top: ' + window.scrollY);
  ```
* [Scroll Examples](./html/scroll.html)