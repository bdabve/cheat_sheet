# <center>Les Tableaux</center>


## Créer un tableau:
```javascript
var films = ["Le loup de Wall Street", "Vice-Versa", "Babysitting"];
var tab = ["Bonjour", 7, true];

fruits = []     // Empty Array
```

### Associative Arrays:

```javascript
balls = {
    "golf": "Golf balls, 6",
    "tennis": "Tennis balls, 3",
    "soccer": "Soccer ball, 1",
    "ping": "Ping Pong balls, 1 doz"
    }

for (ball in balls)
    document.write(ball + " = " + balls[ball] + "<br>)
```
* [Calcule et affiche ensuite la plus grande valeur présente dans un array](./html/max.html)
* [Lists des mots a l'aide d'une boucle `foreach`](./html/mots.html)
* [Affichage a l'aide d'une boucle `for`, et `foreach` et ajout a un array](./html/mousquetaires.html)
* [Calcule la somme des nombre dans un array](./html/somme.html)

### Tableaux méthodes:

```javascript
var films = ["Le loup de Wall Street", "Vice-Versa", "Babysitting"];

console.log(films.length); 				// Obtenir la taille: Affiche 3
console.log(films[1]); 					// Affiche "Vice-Versa"
films.push("Les Bronzés");				// Ajouter un élément
films.pop()                             // Remove the last element('Babysitting)

// Using the concat methode
fruit = ["Banana", "Grape"]
veg = ["Carrot", "Cabbage"]
document.write(fruit.concat(veg))       // Concatenates two arrays

more_fruit = fruit.concat("Orange", "Poire")


// Using the join methode
pets = ['Cat', 'Dog', 'Rabbit', 'Hamster']
console.log(pets.join())                // Cat,Dog,Rabbit,Hamster
console.log(pets.join(' '))             // Cat Dog Rabbit Hamster

// Using the reverse method
sports = ["Football", "Tennis", "Baseball"]
sports.reverse()
console.log(sports)                     // Baseball, Tennis, Football

// Using the sort method
sports = ["Football", "Tennis", "Baseball", "Hockey"]
sports.sort()
document.write(sports + "<br>")
// Reverse alphabetical sort
sports = ["Football", "Tennis", "Baseball", "Hockey"]
sports.sort().reverse()
document.write(sports + "<br>")
// Ascending numeric sort
numbers = [7, 23, 6, 74]
numbers.sort(function(a,b){return a - b})
document.write(numbers + "<br>")
// Descending numeric sort
numbers = [7, 23, 6, 74]
numbers.sort(function(a,b){return b - a})
document.write(numbers + "<br>")

// assign
let objectA = {a: 1, b: 2};
Object.assign(objectA, {b: 3, c: 4});
console.log(objectA);
// → {a: 1, b: 3, c: 4}

// Index OF
console.log([1, 2, 3, 2, 1].indexOf(2));
// → 1
console.log([1, 2, 3, 2, 1].lastIndexOf(2));
// → 3

// Slice
console.log([0, 1, 2, 3, 4].slice(2, 4));
// → [2, 3]
console.log([0, 1, 2, 3, 4].slice(2));
// → [2, 3, 4]

```

* [Array Methods](./html/arrayMethods.html)

## Parcourir:

```javascript
for (var i = 0; i < films.length; i++) {
    console.log(films[i]);
}

films.forEach(function (film) {
    console.log(film);
});

// ou
for (var i = 0, c = myArray.length; i < c; i++) {	
    console.log(myArray[i]);		
}

// Or
for (let entry of JOURNAL) {
  console.log(`${entry.events.length} events.`);
}

for (const e of Journal){
    console.log(e);
}

// Or
films.forEach(output) function output(film){
    console.log(film)
}
```

## Tableaux d'objets:

* Cette déclaration va créer un objet analogue à un tableau, excepté le fait que chaque item sera accessible au moyen d'un identifiant
  
  ```javascript

  var myObject = {};    // un objet vide

  //
  var family = {
      self: 'Sébastien',
      sister: 'Laurence',
      brother: 'Ludovic',
      cousin_1: 'Pauline',
      cousin_2: 'Guillaume'
  };

  // Accès aux items
  family.sister;
  family['sister'];

  // Ajouter des item
  family['uncle'] = 'Didier'; // « Didier » est ajouté et est accessible via l'identifiant « uncle »
  family.uncle = 'Didier';  // Même opération mais d'une autre manière
  ```

### Parcourir un objet avec `for in`

* La boucle `for in` est l'équivalent de la boucle `foreach` du PHP : elle est très simple et ne sert qu'à une seule chose : parcourir un objet.

  ```javascript
  for (var id in family) { // On stocke l'identifiant dans « id » pour parcourir l'objet « family »
	alert(family[id]);		
  }
  ```
### Un autre Example
  
  ```javascript
  var Film = {
      // Initialise le film
      init: function (titre, annee) {
          this.titre = titre;
          this.annee = annee;
      },
      // Renvoie la description du film
      decrire: function () {
          var description = this.titre + " (" + this.annee + ")";
          return description;
      }
  };

  var film1 = Object.create(Film);
  film1.init("Le loup de Wall Street", 2013);

  var film2 = Object.create(Film);
  film2.init("Vice-Versa", 2015);

  var film3 = Object.create(Film);
  film3.init("Babysitting", 2013);
  ```

* [Journal Entry](./html/journal.html)
* [ArrayMethod](./html/arrayMethod.html)
* [Film avec réalisateur](./html/films.html)
* [Exemple d'une chenil](./html/chenil.html)
* [Titi](./html/titi.html)
