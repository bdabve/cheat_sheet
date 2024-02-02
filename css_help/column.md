# <center>Multiple Columns</center>

* The CSS multi-column layout allows easy definition of multiple columns of text - just like in newspapers:

### CSS Multi-column Properties:

* `column-count`: Specifies the number of columns an element should be divided into.

  ```css
  div {
    column-count: 3;
  } 
  ```

* `column-gap`: specifies the gap between the columns.

  ```css
  div{
    column-gap: 40px;
  } 
  ```
* `column-rule-style`: Specifies the style of the rule between columns.

  ```css
  div{
    column-rule-style: solid;
  }
  ```

* `column-rule-width`: Specifies the width of the rule between columns.

  ```css
  div{
    column-rule-width: 1px;
  }
  ```
* `column-rule-color`: Specifies the color of the rule between columns.

  ```css
  div{
    column-rule-color: lightblue;
  }
  ```
* `column-rule`: Shorthand property for setting all the column-rule-* property above.

  ```css
  div{
    columnl-rule: 1px dashed lightblue;
  } 
  ```
* `column-span`: Specifies how many columns an element should span across.

  ```css
  h2 {
    column-span: all;   /* Specifies that the <h2> element should span across all columns.
  } 
  ```

* `column-width`: Specifies a suggested, optimal width for the columns.

  ```css
  div{
    column-width: 100px;    /* Specifies tha the suggested, optimal width for the columns should be 100px. */
  } 
  ```

* `columns`: A shorthand property for setting `column-width` and `column-count`.

  ```css
  div{
    columns: 3 100px;
  } 
  ```

### Example

```html
<!DOCTYPE html>
<html>
  <head>
    <style> 
      .newspaper {
          columns: 3 100px;
          column-gap: 20px;
          column-rule: 2px solid black
      }

      h2 {
          -webkit-column-span: all; /* Chrome, Safari, Opera */
          column-span: all;
      }
    </style>
  </head>
  <body>

    <p><b>Note:</b> Firefox and Internet Explorer 9 (and earlier versions) do not support the column-span property.</p>

    <div class="newspaper">
      <h2>Lorem Ipsum Dolor Sit Amet</h2>
      Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum.
    </div>

  </body>
</html>
```
