# <center>Transitions</center>


* `CSS Transitions`: Allows you to change property values smoothly from one value to another, over a given duration.

* There are four properties you should supply in order to set up a transition, as follows:

  > You must preface these properties with the relevant browser prefixes for Mozilla, WebKit, Opera, and Microsoft browsers.

  > To Create a transition effect, you must specify two things: `css-property` and `transition-duration`


  ```css
  div {
    width: 100px;
    height: 100px;
    background: red;
    -webkit-transition: width 2s;     /* safari, chrome ...*/
    -moz-transition: width 2s;     /* firefox */
    -o-transition: width 2s;     /* Opera */
    -ms-transition: width 2s;     /* IE */
    transition: width 2s;         /* css-property and duration. */
  }

  div:hover{      /* Specify a new value for the width
    width: 300px;
      }
  ```
  
## transition-property: 

* Transitions have properties such as `height` and `border-color`. 

* Specify the properties you want to change in the CSS property named transition-property (here the word property is used by different tools to mean different things). You can include multiple properties by separating them with commas, like this:

  ```css
  div{
    transition: width 2s, height 4s, opacity 2s; 
  }

  div:hover{
    width: 300px;
    height: 200px;
    opacity: .5;
  }
  ```
  
* Or, if you want absolutely everything about an element to transition (including colors), use the value all, like this:

  `transition-property:all;`
  ```css
  div{
    transition: all 2s; 
  }

  div:hover{
    width: 300px;
    height: 200px;
    opacity: .5;
  }
  ```

## transition-duration : 

* Requires a value of 0 seconds or greater, Which specifies that the transition should take 1.25 seconds to complete:

  `transition-duration:1.25s;`

## transition-delay

* If the `transition-delay` is given a value greater than 0 seconds (the default), it introduces a delay between the initial display of the elements and the beginning of the transition.

  ```css
    /* 1 second delay before starting*/
    div{
      transition-delay: 0.1s;
    }
  ```

## `transition-timing-function`: 

* The `transition-timing` function property requires one of the following values:

  `ease`: Start slowly, get faster, and then end slowly.
  
  `linear`: Transition at constant speed.
  
  `ease-in`: Start slowly, and then go quickly until finished.
  
  `ease-out`: Start quickly, stay fast until near the end, and then end slowly.
  
  `ease-in-out`: Start slowly, go fast, and then end slowly.

  ```css
  #div1 {transition-timing-function: linear;} 
  #div2 {transition-timing-function: ease;} 
  #div3 {transition-timing-function: ease-in;} 
  #div4 {transition-timing-function: ease-out;} 
  #div5 {transition-timing-function: ease-in-out;} 
  ```
  
## Transition + transformation

* The following example also adds a tranformation to the transition effect:

  ```css
  div{
    transition: width 2s, height 2s, transform 2s;
  }
  div:hover{
    width: 300px;
    height: 300px;
    transform: rotate(180deg);
      }
  ```

## Shorthand Syntax:

* The CSS transition properties one by one:

  ```css
  div {
    transition-property: width;
    transition-duration: 2s;
    transition-timing-function: linear;
    transition-delay: 1s;
  }   
  ```

* Shorthand property

  ```css
  div {
    transition: width 2s linear 1s;
  }
  ```

*  the following syntax will transition all properties in a linear fashion, over a period of .3 seconds, after an initial (optional) delay of .2 seconds: `transition: property duration timing delay`

  ```css
  a:hover{
      transition:all .3s linear .2s;
  }

  /* Another Example */
  #square{
      transition        :all .8s ease-in-out;
      -moz-transition   :all .8s ease-in-out;
      -webkit-transition:all .8s ease-in-out;
      -o-transition     :all .8s ease-in-out;
      -ms-transition    :all .8s ease-in-out;
  }
  ```

