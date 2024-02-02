# <center>Positioning Elements</center>

## The `position` Property

* Elements are positioned using top, bottom, left and right property.   
However, these properties will not work unless the `position` property is set first. They also work deffrently depending on the postion value.
  * `absolute`
  * `relative`
  * `fixed`
  * `sticky`.


* Position `absolute`: An element with absolute positioning is removed from the document, and any other elements that are capable will flow into its released space.  
  You can then position the object anywhere you like within the document by using the `top, right, bottom, left` properties. It will then rest on top of (or behind) other elements.

```css
div.relative {
    position: relative;
    width: 400px;
    height: 200px;
    border: 3px solid #73AD21;
} 

div.absolute {
    position: absolute;
    top: 80px;
    right: 0;
    width: 200px;
    height: 100px;
    border: 3px solid #73AD21;
}
```

* Position `relative`: an element with `position: relative` is positioned relative to its normal position.   
  Setting the top, right, bottom and left properties of a relatively-positioned element will cause it to be adjusted away from its normal postion. 

```css
#object {
  position: relative;
  top: 10px;
  left: 10px;
}
```

* Postion `fixed`: Is positioned relative to the viewport, wich means it always stays in the same place even if the page is scrolled.   
  The top, right, bottom, and left properties are used to position the element.

```css
div.fixed {
  position:fixed;
  top: 0;
  left: 0;
  width: 300px;
}
```

* Position `sticky`: Is positioned based on the user's scroll position.
  A sticky element toggles between `relative` and `fixed`, depending on the scroll position. It is positioned relative until a given ofsset position is met in the viewport - then it `sticks` in place(like position:`fixed`).

  ```css
  div.sticky {
    position: -webkit-sticky; /* Safari */
    position: sticky;
    top: 0;
    background-color: green;
    border: 2px solid #4CAF50;
  }
  ```

## Overlapping Elements

When elements are positioned, they can overlap other elements.

The `z-index` property specifies the stack order of an element (which element should be placed in front of, or behind, the others)

```css
img {
  position: absolute;
  left: 0px;
  top: 0px;
  z-index: -1;  /* it will be placed behind the text */
}
```

## `clip` Property

* The `clip` property lets you specify a rectangle to clip an absolutely positioned element. The rectangle is specified as four coordinates, all from the top-left corner of the element to be clipped.

  > The `clip` property does not work if `overflow: visible`.

* Syntax: `clip: auto | shape | initial | inherit;`

  ```css
  div#myBox {
      position:absolute;
      background-color:yellow;
      width:100px;
      clip:rect(10px,100px,100px,10px);
  }
  ```
  
* [Cours Example](./cours/position.html)

## `calc()` Function: 

* The `calc()` function performs a calculation to be used as the property value.
  
  > Syntax: calc(+ | - | * | /)

  ```css
  .div {
      float: left;
      width: calc(100% - 100px);
      background-color: #00F;
      color: #fff;
  }
  ```

* [Cours Example](./cours/calc.html)
