# <center>Flex Box</center>

## Parent Element (container)

* The flex container becomes flexible by setting the `display` property to `flex`.

```css
.container {
  display: flex;
}
```

* The flex container properties are:

  * `flex-direction`
  * `flex-wrap`
  * `flex-flow` 
  * `justify-content`
  * `align-items`
  * `align-content`

### `flex-direction`: 

* Define in which derection the container wants to stack the flex items.
* Values: `(row || row-reverse || column || column-reverse)`

```css
.flex-contaner{
  display: flex;
  flex-direction: column;
}
```

### `flex-wrap`: 

* Specifies whether the flex items should wrap or not.
* Values: `(wrap || nowrap || wrap-reverse)`

```css
.flex-contaner{
  display: flex;
  flex-wrap: wrap;
}
```

### `flex-flow`: 

* Shorthand for setting both the `flex-direction` and `flex-wrap` properties.
* Values: `(flex-direction flex-wrap)`

```css
.flex-contaner{
  display: flex;
  flex-flow: row wrap;
}
```

* [Cours Example](cours/flexBox-flexDirection-flexWrap-flexFlow.html)

### `justify-content`: 

* Align the flex items
* Values: `(flex-start || flex-end || center || space-between || space-around )`

```css
.flex-contaner{
  display: flex;
  justify-content: space-between;
}
```
* [Cours Example](cours/flexBox-justifyContent.html)

### `align-items`: 

* Align the flex items vertically
* Values: `align-items(stretch(default) || flex-start(top) || flex-end(bottom) || center(middle) || baseline(baseline aligns))`.

```css
.flex-contaner{
  display: flex;
  height: 200px;
  align-items: baseline;
}
```

* [Cours Example](cours/flexBox-alignItems.html)

### `align-content`: 

* Align the flex lines verticaly.
* Values: `align-content(stretch ||flex-start || flex-end || center || space-between || space-around )`

```css
.flex-contaner{
  display: flex;
  height: 200px;
  flex-wrap: wrap;
  align-content: space-between;
}
```

* [Cours Example](cours/flexBox-alignContent.html)

### Example of Perfect Centering.

```css
.flex-container{
  display: flex;
  height: 300px;
  justify-content: center;
  align-items: center;
}
```
* [Perfect Centering](cours/flexBox-perfectCentering.html)

## Child Element (items)

* the direct child elements of a flex container automatically becomes flexible items.
* The flex items properties are:
  * `order`
  * `flex-grow`
  * `flex-shrink`
  * `flex-basis
  * flex
  * align-self

### `order`:

* Specifies the order of the flex items.
* Values: `order number`


```html
<div class="flex-container">
  <div style="order: 3">1</div>
  <div style="order: 1">2</div>
  <div style="order: 2">3</div>
</div>
```

### `flex-grow`:

* Specifies how much a flex item will grow relative to the rest of the flex items.
* Values: `how much times the element grow than the other items`


```html
<div class="flex-container">
  <div style="flex-grow: 1">1</div>
  <div style="flex-grow: 1">2</div>
  <div style="flex-grow: 2">3</div>
</div>
```

### `flex-shrink`:

* Specifies how much a flex item will shrink relative to the rest of the flex items.
* Values: `how much times the element shrink than the other items, must a number. Default is 1`

```html
<!-- Do not let the third flex item shrink as much as the other flex items -->
<div class="flex-container">
  <div>1</div>
  <div>2</div>
  <div style="flex-shrink: 0">3</div>
  <div>4</div>
  <div>5</div>
  <div>6</div>
  <div>7</div>
</div>
```

### `flex-basis`:

* Specifies the initial length fo a flex item.
* Values: in `px` or `auto` is the default value

```html
<!-- Set the initial lenght of the third flex item to 200px -->
<div class="flex-container">
  <div>1</div>
  <div>2</div>
  <div style="flex-basis: 200px">3</div>
  <div>4</div>
</div>
```

### `flex`:

* Is a shorthand property of `flex-grow`, `flex-shrink`, and `flex-basis` properties.
* Values: `flex-grow flex-shrink flex-basis`

```html
<!-- Make the third item not growable, not shrinkable and initial length of 200px -->
<div class="flex-container">
  <div>1</div>
  <div>2</div>
  <div style="flex: 0 0 200px">3</div>
  <div>4</div>
</div>
```

### `align-self`:

* Specify the alignment for the selected item inside the flexible container.
* Override the default alignment set by the container's `align-items` property.
* Values: Same value as `align-items`

```html
<!-- align the second flex item at the top of the conainer, and the third flex item at the bottom of the container -->
<div class="flex-container">
  <div>1</div>
  <div style="align-self: flex-start;">2</div>
  <div style="align-self: flex-end;">3</div>
  <div>4</div>
</div>
```

