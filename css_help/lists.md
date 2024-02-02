# <center>CSS Lists Properties</center>

* The CSS list properties allow you to:
  * Set different list item markers for ordered lists
  * Set different list item markers for unordered lists
  * Set an image as the list item marker
  * Add background colors to lists and list items
  
* `list-style-type`: Specifies the type of list item marker.<br><br>

  ```css
  /* Unordered lists. */
  ul.a {
    list-style-type: circle; 
  }

  ul.b {
    list-style-type: square;
  }

  /* Ordered lists */
  ol.c {
    list-style-type: upper-roman;
  }

  ol.d {
    list-style-type: lower-alpha;
  }
  ```

* `list-style-image`: Specifies an image as the list item marker.<br><br>

  ```css
  list-style-image: url('sqpurple.gif');
  ```

* `list-style-position`: Specifies the position of the list-item markers (bullet points).<br><br>

  ```css
  ul.a {
    list-style-position: outside; /* The bullet points will be outside the list items.*/
  }

  ul.b {
    list-style-position: inside; /* The bullet points will be inside the list item.*/
  }
  ```
  
* `list-style-type :none` Property can also be used to remove the markers/bullets.<br><br> 

  > Note that the list also has default margin and padding. To remove this, add `margin:0` and `padding:0` to `<ul>` or `<ol>`
  
  ```css
  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
  }
  ```
  
### List - Shorthand property

* the order of the property values are: `list-style-type` `list-style-position` `list-style-image`

  ```css
  ul {
    list-style: square inside url("sqpurple.gif");
  }

  ```
  
### Styling List With Colors

```css
ol {
    background: #ff9999;
    padding: 20px;
}

ol li {
    background: #ffe5e5;
    padding: 5px;
    margin-left: 35px;
}

ul {
    background: #3399ff;
    padding: 20px;
}

ul li {
    background: #cce5ff;
    margin: 5px;
}
```

### Examples

#### Full-width bordered list:

```html
    <head>
        <style>
        ul {
            list-style-type: none;
            padding: 0;
            border: 1px solid #ddd;
        }

        ul li {
            padding: 8px 16px;
            border-bottom: 1px solid #ddd;
        }

        ul li:last-child {
            border-bottom: none
        }
        </style>
    </head>
    <body>

        <p>Full-width bordered list:</p>
        <ul>
          <li>Coffee</li>
          <li>Tea</li>
          <li>Coca Cola</li>
        </ul>

    </body>
```

#### List with a red left border:

```html
<head>
    <style>
    ul {
        border-left: 5px solid red;
        background-color: #f1f1f1;
        list-style-type: none;
        padding: 10px 20px;
    }
    </style>
</head>
<body>
    <p>List with a red left border:</p>
    <ul>
      <li>Coffee</li>
      <li>Tea</li>
      <li>Coca Cola</li>
    </ul>
</body>
```