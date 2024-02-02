## Les Fonction:

### Déclaration et appel:

```javascript
function direBonjour() {
    console.log("Bonjour !");
}

direBonjour(); 	// appel a la fonction


```

### Valeur de retour

```javascript
function direBonjour() {
    return "Bonjour !";
}

var resultat = direBonjour();
console.log(resultat);


```

### Passage de paramètres:

```javascript
function direBonjour(prenom) {
    var message = "Bonjour, " + prenom + " !";
    return message;
}

console.log(direBonjour("Baptiste"));
console.log(direBonjour("Sophie"));

//
const square = function(x) {
  return x * x
};
console.log(square(12));
-> 144
//
const power = function(base, exponent) {
let result = 1;
for (let count = 0; count < exponent; count++) {
result *= base;
}
return result;
};
console.log(power(2, 10));
// → 1024
```

* If you write an `=` operator after a parameter, followed by an expression, the value of that expression will replace the argument when it is not given

  ```javascript
  function power(base, exponent = 2) {
    let result = 1;
    for (let count = 0; count < exponent; count++) {
      result *= base;
    }
  return result;
  }

  console.log(power(4));
  // → 16
  console.log(power(2, 6));
  // → 64

  ```

### Les fonctions anonymes

* Les fonctions spéciales sont anonymes car elles ne possèdent pas de nom.
* Pour déclarer une fonction anonyme, il vous suffit de faire comme pour une fonction classique mais sans indiquer de nom:

  ```javascript
  function (arguments) {
      // Le code de votre fonction anonyme
  }

  var sayHello = function() {
      alert('Bonjour !');
  };
  ```

#### Immediately-Invoked Function Expression (IIFE)
* Une fonction, lorsqu'elle est déclarée, n'exécute pas immédiatement le code qu'elle contient, elle attend d'être appelée. Or, nous, nous souhaitons exécuter ce code immédiatement ! La solution est donc d'utiliser ce couple de parenthèses.

  ```javascript
  (function() {
      // Code isolé
  })();

  var test = 'noir'; // On crée une variable « test » contenant le mot « noir »

  (function() { // Début de la zone isolée

      var test = 'blanc'; // On crée une variable du même nom avec le contenu « blanc » dans la zone isolée

      alert('Dans la zone isolée, la couleur est : ' + test);

  })(); // Fin de la zone isolée. Les variables créées dans cette zone sont détruites.

  alert('Dans la zone non-isolée, la couleur est : ' + test); // Le texte final contient bien le mot « noir » vu que la « zone isolée » n'a aucune influence sur le reste du code

  var sayHello = (function() {

      return 'Yop !';

  })();

  alert(sayHello); // Affiche : « Yop ! »
  ```

### Arrow functions

* Instead of the function keyword, it uses an arrow (`=>`) made up of an equal sign and a greater-than character.
  
  ```javascript
  const power = (base, exponent) => {
  let result = 1;
  for (let count = 0; count < exponent; count++) {
  result *= base;
  }
  return result;
  };
  ```
* When there is only one parameter name, you can omit the parentheses around the parameter list. If the body is a single expression, rather than a block in braces, that expression will be returned from the function.

  ```javascript
  //  these two definitions of square do the same thing
  const square1 = (x) => { return x * x; };
  const square2 = x => x * x;
  ```
* When an arrow function has no parameters at all, its parameter list is just an empty set of parentheses.

  ```javascript
  const horn = () => {
    console.log("Toot");
  };
  ```
  


## Rest parameters

* It can be useful for a function to accept any number of arguments. For example, `Math.max` computes the maximum of all the arguments it is given.

* To write such a function, you put three dots before the function's last parameter.

  ```javascript
  function max(...numbers) {
    let result = -Infinity;
    for (let number of numbers) {
      if (number > result) result = number;
    }
    return result;
  }
  
  console.log(max(4, 1, 9, -2));
  // → 9
  ```

### Examples

* Define a recursive function isEven corresponding to: 
  * Zero is even.
  * One is odd.
  * For any other number N, its evenness is the same as N - 2.
 
 ```javascript
  function isEven(n) {
    if (n == 0) return true;
    else if (n == 1) return false;
    else if (n < 0) return isEven(-n);
    else return isEven(n - 2);
  }
  console.log(isEven(50));
  // → true
  console.log(isEven(75));
  // → false
  console.log(isEven(-1));
  // → false
  ```

* Write a function countBs that takes a string as its only argument and returns a number that indicates how many uppercase "B" characters there are in the string.

* write a function called countChar that behaves like countBs, except it takes a second argument that indicates the character that is to be counted 

  ```javascript
  function countChar(string, ch) {
    let counted = 0;
    for (let i = 0; i < string.length; i++) {
      if (string[i] == ch) {
        counted += 1;
      }
    }
    return counted;
  }

  function countBs(string) {
    return countChar(string, "B");
  }

  console.log(countBs("BBC"));
  // → 2
  console.log(countChar("kakkerlak", "k"));
  // → 4
  ```
  
### More Examples
* [Exemple Self Invoke](./html/selfInvoke.html)

* [Exemple Calculette](./html/calculatrice.html)
* [Exemple Caree](./html/caree.html)
* [Exemple Dire Bonjours](./html/dirBonjours.html)
* [Exemple Min Number](./html/min.html)
* [Exemple Self Invoke](./html/selfInvoke.html)
* [From Numbers To Lettres](./html/fromNumberToLettre.html)


