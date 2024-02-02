# <center>Animez Vos Pages</center>

## Using setInterval

  ```javascript
  <p>The time is: <span id='time'>00:00:00</span><br><p>

  // Time span
  setInterval("showtime(document.getElementById('time'), 1000)") 
  // calling showtime function with id of the element, which is set to execute once a second (every 1.000 milliseconds)

  function showtime(object){
      var date = new Date(); // Every time showtime is called, it sets the object date to the current date and time.
      object.innerHTML = date.toLocaleTimeString().substr(0,8)
      /* Set object.innerHTML to the current time in hours, minute, and seconds by a call to toTimeString.
       * This returns a string such as 09:57:17 UTC+0530
       * Truncat to just 8 char with substr
       */
  }
  ```

* [Simple redirection with setInterval](./html/redirection.html)

### Cancelling an interval

* To stop a repeating interval, when you first set up the interval with a call to the function `setInterval` , you must make a note of the interval's handle, like this:

  ```javascript
  handle = setInterval("showtime(O('time'))", 1000)

  // Now you can stop the clock at any time by issuing the following call:
  clearInterval(handle)
  ```
* You can even set up a timer to stop the clock after a certain amount of time, like this:

  ```javascript
  setTimeout("clearInterval(handle)", 10000)
  ```
  > This statement will issue an interrupt in 10 seconds that will clear the repeating intervals.

## Using setTimeout

* When you call `setTimeout`, you pass it some JS code or the name of a function, and the value in milliseconds reprsenting how long to wait before the code should be executed

  ```javascript
  setTimeout(dothis, 5000);

  funtion dothis(){
    alert ('This is your wakeUp alert!');
  }

  // OR
  setTimeout("alert('Hello!')", 5000);

  // Another example
  setTimeout("document.write('Starting'); alert('Hello!')", 5000)

  // 
  setTimeout(function(){ 
    title.textContent = "Done Updating"; 
    }, 2000);
  ```

### Repeating time-outs: 

* One technique some programmers use to provide repeating interrupts using the function `setTimeout` is to call the `setTimeout` function from the code called by it, as with the following, which will initiate a never-ending loop of alert windows
  
  ```javascript
  setTimeout(dothis, 5000);

  function dothis(){
    setTimeout(dothis, 5000);
    alert('I am annoying!');
  }
  ```

### Cancelling a Time-Out: 

* Once a time-out has been set up, you can cancel it if you previously saved the value returned from the initial call to `setTimeout`, like this

  ```javascript
  handle = setTimeout(dothis, 5000);
  clearTimeout(handle);
  ```

## Using Interrupts for Animation

* By combining a few CSS properties with a repeating interrupt, you can produce all manner of animations and effects

  ```javascript
  SIZE = LEFT = 0;
  setInterval(animate, 30)

  function animate(){
      SIZE += 10
      LEFT += 3

      if (SIZE == 200) SIZE = 0;
      if (LEFT == 600) SIZE = 0;

      document.getElementById('box').style.width = SIZE + 'px';
      document.getElementById('box').style.height = SIZE + 'px';
      document.getElementById('box').style.left = LEFT + 'px';
  }
  ```
  
* `requestAnimationFrame`: permet de demander au navigateur d'exécuter dés que possible une fonction qui met à jour une animation .

  ```javascript
  function animer(){
    // code de l'animation
    // ...
    requestAnimationFrame(animer);
  } 
  requestAnimationFrame(animer);
  ```
* Stoper une animation

  ```javascript
  // Deplacement du bloc

  var bloc = document.getElementById('bloc');
  var cadre = document.getElementById('cadre');
  var vitesse = 7;  // Valeur de déplacement en pixels

  // Conversion en nombre du diamètre du bloc
  var largeurBloc = parseFloat(getComputedStyle(bloc).width);
  var animationId = null; // Identifiant de l'animation

  // Déplace le bloc sur sa gauche jusqu'au bord du cadre
  function deplacerBloc(){
      // Conversion en nombre de la position gauche du bloc
      var xBloc = parseFloat(getComputedStyle(bloc).left);
      // Conversion en nombre de la largeur du cadre
      var xMax = parseFloat(getComputedStyle(cadre).width);
      if (xBloc + largeurBloc <= xMax) { // si le bloc n'est pas encore au bout du cadre
          // Deplacement
          bloc.style.left = (xBloc + vitesse) + "px";
          // Demande au navigateur d'appeler deplacerBloc dés que possible
          animationId = requestAnimationFrame(deplacerBloc);
      } else {
          // Annulation de l'animation
          cancelAnimationFrame(animationId);
      }
  }
  animationId = requestAnimationFrame(deplacerBloc);    // Début de l'animation
  ```

* [Course Example](./html/cours.html)