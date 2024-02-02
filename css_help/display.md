# <center>The Display Propertie</center>

* `display`: Is the most important CSS property for controlling layout.
* The `display` property specifies if/how an element is displayed.
* Every HTML element has a default display value depending on what type of element it is. The default display value for most elements is `block` or `inline`.


### Block-level Elements

* A block-level element always starts on a new line and takes up the full width available (stretches out to the left and right as far as it can).

* Examples of block-level elements:

  ```html
  <div>
  <h1> - <h6>
  <p>
  <form>
  <header>
  <footer>
  <section>
  ```

### Inline Elements

* An inline element does not start on a new line and only takes up as much width as necessary.

* Examples of inline elements:

  ```html
  <span>
  <a>
  <img>
  ```

| Value  | Examples | Description |
| -------|:--------:|:-----------:|
| inline | `<a>,<em>, <span>` | Elément d'une ligne. Se placent les uns à côté des autres.
| block | `<p>, <div>, <section>` | Elément en forme blocs, Se placent les uns en-dessous des autres et peuvent être redimensionnés
| inline-block | `<select>, <input>` | Elément positionnés les uns à côté des autres mais qui peuvent être redimensionnés
| none | `<head>` | Eléments non affichés


### Override The Default Display Value

* As mentioned, every element has a default display value. However, you can override this.

* A common example is making inline `<li>` elements for horizontal menus:

  ```css
  li {
    display: inline;
  }
    
  a {
    display: block;        /* From inline to block */
  }
  ```
  
### Hide an Element with `display:none` or `visibility:hidden`?

* `display: none;`: The element will be hidden, and the page will be displayed as if the element is not there.
* `visibility:hidden`: The element will be hidden, and still take up the same space as before.<br><br>

   > visibility syntax: `visibility: visible|hidden|collapse|initial|inherit;`


* Nous allons transformer en inline-block les deux éléments que nous voulons placer côte à côte : le menu de navigation et la section du centre de la page.

```css
nav {
  display: inline-block;
  width: 150px;
  border: 1px solid black;
  vertical-align: top;
}

section {
  display: inline-block;
  border: 1px solid blue;
  vertical-align: top;
}
```

### Exampls

```html
<head>
    <style>
    #panel, .flip {
        font-size: 16px;
        padding: 10px;
        text-align: center;
        background-color: #4CAF50;
        color: white;
        border: solid 1px #a6d8a8;
        margin: auto;
    }

    #panel {
        display: none;
    }
    </style>
</head>
<body>

    <p class="flip" onclick="myFunction()">Click to show panel</p>
    <div id="panel">
      <p>This panel contains a div element, which is hidden by default (display: none).</p>
      <p>It is styled with CSS and we use JavaScript to show it (display: block).</p>
      <p>How it works: Notice that the p element with class="flip" has an onclick attribute attached to it. When the user clicks on the p element, a function called myFunction() is executed, which changes the style of the div with id="panel" from display:none (hidden) to display:block (visible).</p>
    </div>
    <script>
        function myFunction() {
            document.getElementById("panel").style.display = "block";
        }
    </script>

</body>
```