# <center>Animation</center>

## What are CSS Animations?

* An animation lets an element gradually change from one style to another.

* You can change as many CSS properties you want, as many times you want.

* To use CSS animation, you must first specify some keyframes for the animation.

* Keyframes hold what styles the element will have at certain times.

### The `@keyframes` Rule

* When you specify CSS styles inside the `@keyframes` rule, the animation will gradually change from the current style to the new style at certain times.

* To get an animation to work, you must bind the animation to an element.

* Syntax: 

  ```css
  /* Defining Function */
  @keyframes name {    /* name is the name of the animation */
      from {}
      to {}
  }

  /* Another Syntax */
  @keyframes moving {
      0% {}
      25%{}
      50%{}
      100%{}
  }
  /* Calling the animation */
  div {
      animation: name 5s 5;
  }
  ```

* [Cours Example](../css/cours/animation.html)

## Animation Name, Duration:

* `animation-name`: The name of the animation required.

* `animation-duration`: property defines how long time an animation should take to complete. If the animation-duration property is not specified, no animation will occur, because the default value is 0s.

  ```css
  div {
      position: absolute;
      top: 0;
      left: 0;
      animation-name: move;
      animation-duration: 5s;
  }
  @keyframes move{
      0% {
          top: 0;
          left: 100px;
      }
      50% {
          top: 200px;
          left: 100px;
      }
      100%{
          top:0px;
          left: 300px;
      }
  }
  ```

* [Cours Example](../css/cours/animationNameDuration.html)

## Animation Iteration count, Direction:

* `animation-iteration-count` property specifies the number of times an animation should run.

* `animation-direction` property specifies whether an animation should be played forwards, backwards or in alternate cycles.
  * normal - The animation is played as normal (forwards). This is default
  * reverse - The animation is played in reverse direction (backwards)
  * alternate - The animation is played forwards first, then backwards
  * alternate-reverse - The animation is played backwards first, then forwards
  
  ```css
  div {
      position: absolute;
      top: 0;
      left: 0;
      animation-name: move;
      animation-duration: 5s;
      animation-iteration-count: infinte;
      animation-direction: alternate;
  }
  @keyframes move{
      0% {
          top: 0;
          left: 100px;
      }
      50% {
          top: 200px;
          left: 100px;
      }
      100%{
          top:0px;
          left: 300px;
      }
  }
  ```
  
* [Cours Example](../css/cours/animation-iteration-direction.html)

## Animation Dellay, Fill mode:

* `animation-delay` property specifies a delay for the start of an animation.

* `animation-fill-mode` property specifies a style for the target element when the animation is not playing (before it starts, after it ends, or both).
  * none - Default value. Animation will not apply any styles to the element before or after it is executing
  * forwards - The element will retain the style values that is set by the last keyframe (depends on animation-direction and animation-iteration-count)
  * backwards - The element will get the style values that is set by the first keyframe (depends on animation-direction), and retain this during the animation-delay period
  * both - The animation will follow the rules for both forwards and backwards, extending the animation properties in both directions
  
  ```css
  div {
      position: absolute;
      top: 0;
      left: 0;
      animation-name: move;
      animation-duration: 5s;
      animation-iteration-count: infinte;
      animation-direction: alternate;
      animation-delay: 4s;
      animation-fill-mode: both;
      animation-delay: 4s;
  }
  @keyframes move{
      0% {
          top: 0;
          left: 100px;
      }
      50% {
          top: 200px;
          left: 100px;
      }
      100%{
          top:0px;
          left: 300px;
      }
  }
  ```
  
* [Cours Example](../css/cours/animation-dellay-fillMode.html)

## Animation Play State, Timing Function:

* `animation-play-state` property specifies whether the animation is running or paused.

* `animation-timing-function` property specifies the speed curve of the animation.
  * ease - Specifies an animation with a slow start, then fast, then end slowly (this is default)
  * linear - Specifies an animation with the same speed from start to end
  * ease-in - Specifies an animation with a slow start
  * ease-out - Specifies an animation with a slow end
  * ease-in-out - Specifies an animation with a slow start and end
  * cubic-bezier(n,n,n,n) - Lets you define your own values in a cubic-bezier function
  
  ```css
  div {
      position: absolute;
      top: 0;
      left: 0;
      animation-name: move;
      animation-duration: 5s;
      animation-iteration-count: infinte;
      animation-direction: alternate;
      animation-delay: 4s;
      animation-fill-mode: both;
      animation-timing-function: ease;
      animation-play-state: paused;
  }
  @keyframes move{
      0% {
          top: 0;
          left: 100px;
      }
      50% {
          top: 200px;
          left: 100px;
      }
      100%{
          top:0px;
          left: 300px;
      }
  }
  ```
  
* [Cours Example](../css/cours/animation-playState-timingFunction.html)

## Animation Shorthand Property

* animation: 
  * `animation-name` 
  * `animation-duration` 
  * `animation-timing-function` 
  * `animation-delay` 
  * `animation-iteration-count` 
  * `animation-direction` 
  * `animation-fill-mode` 
  * `animation-play-state `

  ```css
  div {
      /* Default Valus */
      animation: none 0 ease 0 1 none none running;
      
      /* Valus */
      animation: moving 5s ease 0s 2 normal none running;
  }
  ```

* [Cours Example](../css/cours/animation-Shorthand.html)

## More Examples

* [Animation - Create Swing Dropdown](../css/cours/Animation-Create-Swing-Dropdown.html)
* [Animation - Create Wave Audio Loading](../css/cours/Animation-CreateWaveAudioLoading.html)
* [Animation - Create Snake Loading](../css/cours/Animation-Create-snake-loading.html)

* [A collection of CSS3 powered hover effects](http://ianlunn.github.io/Hover/)
* [Library for animation on github](https://daneden.github.io/animate.css/)
* [Useful Animation](http://www.theappguruz.com/tag-tools/web/CSSAnimations/)
* [HTML Template](https://www.css3maker.com)
