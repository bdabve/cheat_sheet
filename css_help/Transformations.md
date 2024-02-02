# <center>Transformations</center>

## 2D Transform

* Using transformations, you can skew, rotate, stretch, and squash elements in any of up to three dimensions.

* To perform a transformation, use the `transform` property ( browser-specific prefixes) [refer to](http://caniuse.com)).

### 2D Transform - Rotates

* `rotate(deg)`: Rotates an element clockwise or counter-clockwise according to a given degree.
  
  ```css
  div:hover{
    transform: rotate(-30deg);
  }
  ```
* [Cours Example](./cours/2dTransform-rotate.html)

### 2D Transform - Scales

* `scale(width, height)`: Increases or decreases the size of an element (according to the parameters given for the width and height). 
* `scaleX(1)`: Width \* 1.
* `scaleY(1)`: Height \* 1.
* `scale(2)`: width \*2, height \*2.
  
  ```css
  .div:hover{
    transform: scale(2, 2);       /* Width x 2 and Height x 2, scale(2): width and height x 2 */
  }
  ```

* [Cours Example](./cours/2dTransform-scale.html)

### 2D Transform - Translate

* `translate(x, y)`: Moves an element from its current position (according to the parameters given for the X-axis and the Y-axis).

* `translateX(40px)`: Move 40px Right, `translateY(40px)`: Move 40px Bottom.
* `translateX(-40px)`: Move 40px Left, `translateY(-40px)`: Move -40px top.
  
  ```css
  .div:hover{
    transform: translate(10px, 10px);       /* 10px Right, 10px bottom (Left and Top use (-10px, -10px))*/
  }
  ```

* [Cours Example](./cours/2dTransform-translate.html)

### 2D Transform - Skews

* `skew(x, y)`: Skews an element along the X and Y-axis by the given angles.
* `skewY()`: Method skews an element along the Y-axis by the given angle.
* `skewX()`: Method skews an element along the X-axis by the given angle.
  ```css
  .div:hover{
    transform: skew(10deg, 10deg);       
  }
  ```
* [Cours Example](./cours/2dTransform-skew.html)

### 2D Transform - Matrix 

* `matrix()`: Method combines all the 2D transform methods into one.

* `matrix(scaleX, skewY, skewX, scaleY, translateX, translateY)`.

  ```css
  img:hover{
    transform: matrix(0.86, 0.5, -0.5, 0.86, 300, 100)
  }
  ```
  
* [Cours Example](./cours/2dTransform-matrix.html)

## 3D Transform

### 3D Transform - RotateX()

* `rotateX()`: Method rotates an element around its X-axis at a given degree.
* `rotateY()` : Method rotates an element around its Y-axis at a given degree.
* `rotateZ()` : Method rotates an element around its Z-axis at a given degree

* [Cours Example](./cours/3dTransform-Rotate-X-Y-Z.html)

### 3D Transform - Translate()

* `translate3d(x, y, z)`: Moves an element from its current position in 3d

* `z`: move forward and backward.

* [Cours Example](./cours/3dTransform-Translate.html)

### 3D Transform - Scale()


* [Cours Example](./cours/3dTransform-Scale.html)

### 3D Transform - Matrix3d()

* [Cours Example](./cours/3dTransform-Matrix.html)

### 3D Transform - Perspective() and Perspective-origin()

* `perspective` property is used to give a 3D-positioned element some perspective.
* `perspective` property defines how far the object is away from the user. So, a lower value will result in a more intensive 3D effect than a higher value.
* `perspective-origin` property defines at from which position the user is looking at the 3D-positioned element.
    
    > The `perspective-origin` must be used in conjunction with the `perspective` property!

* When defining the `perspective` or `perspective-origin` property for an element, it is the CHILD elements that get the perspective view, NOT the element itself.

* [Cours Example](./cours/3dTransform-Perspective.html)

### 3D Transform - Origin()

* 

* [Cours Example](./cours/3dTransform-Origin.html)
