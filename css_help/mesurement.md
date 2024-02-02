# <center>Measurements</center>


* `Pixels`: The size of a pixel varies according to the dimensions and pixel depth of the user’s monitor. One pixel equals the width/height of a single dot on the screen, and so this measurement is best suited to monitors.

* `Points`: A point is equivalent in size to 1/72 of an inch. The measurement comes from a print design background and is best suited for that medium, but is also commonly used on monitors.

* `Inches`: An inch is the equivalent of 72 points and is also a measurement type best suited for print.

* `Centimeters`: are another unit of measurement best suited for print. One centimeter is a little over 28 points.

* `Millimeters`: A millimeter is 1/10 of a centimeter(or  almost  3  points). Millimeters are another measure best suited to print.

* `Picas`: A pica is another print typographic measurement, which is equivalent to 12 points.

* `Ems`: An em is equal to the current font size and is therefore one of the more useful meas‐urements for CSS since it is used to describe relative dimensions.

* `Exs`: An ex is also related to the current font size; it is equivalent to the height of a lowercase letter x. This is a less popular unit of measurement that  is most often used as a good approximation for helping to set the width of a box that will con‐tain some text.

* `Percent`: This unit is related to the em in that it is exactly 100 times greater(when used on a font). Whereas 1em equals the current font size, the same size  is  100  in  percent.  
  
  When not relating to a font, this unit is relative to the size of the container of the property being accessed. 

```css
.classname { 
  margin:5px; 
  font-size:14pt; 
  width:3in;
  height:2cm;
  font-size:5mm;
  font-size:1pc;
  font-size:2em;
  width:20ex;
  height:120%;
}
```
