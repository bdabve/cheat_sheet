# <center>Object</center>

## A Simple Object:


```javascript
var stylo = {
    type: "bille",
    couleur: "bleu",
    marque: "Bic"
};

console.log(stylo.type); 		   // -> "bille"
console.log(stylo.couleur); 	   // -> "bleu"
console.log(stylo.marque); 		   // -> "Bic"

// Il existe une autre syntaxe
console.log(stylo['type']);       // -> "bille"
console.log(stylo['couleur']);    // -> "bleu"
console.log(stylo['marque']);     // -> "Bic"
```

* You can use the this keyword inside a method to refer to the object on which the method is currently being called.
  
  ```javascript
  dog.bark = function () {
    console.log("Woof woof! My name is " + this.name + "!");
  };

  dog.bark();   // -> Woof woof! My name is Pancake!
  ```

### Sharing a Method Between Multiple Objects

* To share methods between multiple objects, you can simply add them to each object
  
  ```javascript
  var speak = function(){
    console.log(this.sound + "! My name is: " + this.name);
  }

  var pig = {
   sound: "Oink",
   name: "Charlie",
   speak: speak
  };

  var horse = {
   sound: "Neigh",
   name: "Marie",
   speak: speak
  };

  pig.speak();      // -> Oink! My name is Charlie!

  horse.speak();  // -> Neigh! My name is Marie!
  ```

## Creating Objects Using Constructors:

* A JavaScript constructor is a function that creates objects and gives them a set of built-in properties and methods.
* Think of it as a specialized machine for creating objects.
* Each time you call a constructor, it creates an object and gives the new object built-in properties.
* The keyword `new` tells JavaScript that we're calling a constructor to create a new object
  
  ```javascript
  var Car = function(x, y, name) {
    this.x = x;
    this.y = y;
    this.name = name;
  };

  var drawCar = function(car) {
    // Create a string containing HTML that points to an image of a car
    var carHtml = '<div>' + car.name +'</div>'; // 

    // Pass carHTML to the $ function, which converts it from a string to a jQuery element.
    var carElement = $(carHtml);

    // Use the css method on carElement to set the position of the car image. 
    carElement.css({
        position: "absolute",
        left: car.x,
        top: car.y,
        border: '1px solid black',
        width: '100px',
        height: '40px',
        backgroundColor: '#EEE'
    });

    // Append our element to body
    $("body").append(carElement);
  }

  // Testing the drawing Car
  var tesla = new Car(10, 20, 'Tesla');
  var nissan = new Car(100, 200, 'Nissan');

  drawCar(tesla);
  drawCar(nissan);  
  ```

  * [Code Example](./html/carObject.html)

  <details>
  <summary>Open Class Rooms Example:</summary>

  ```javascript
  // Constructeur MonObjet
  function MonObjet() {
      // Initialisation de l'objet
      // ...
  }
  // Instanciation d'un objet à partir du constructeur
  var monObj = new MonObjet();

  // Un Autre exemple
  function User(forename, username, password) {
      this.forename = forename
      this.username = username
      this.password = password

      this.showUser = function(){
        document.write("Forename: " + this.forename + "<br>")
        document.write("Username: " + this.username + "<br>")
        document.write("Password: " + this.password + "<br>")
      }
  }

  details = new User("Wolfgang", "w.a.mozart", "composer")

  // l'autre syntaxe
  details = new User()
  details.forename = "Wolfgang"
  details.username = "w.a.mozart"
  details.password = "composer"
  details.showUser()
  ```
  
  * [Objet Declaration et Modification](./html/objetDeclarationModif.html)
  </details>



### Customizing Objects with Prototypes

* A more object-oriented way to draw our cars would be to give each car object a `draw` method. 
* Then, instead of writing `drawCar(tesla)`, you’d write `tesla.draw()`.
* JavaScript prototypes make it easy to share functionality (as methods) between different objects. All constructors have a prototype property, and we can add methods to it. 
* Any method that we add to a constructor’s prototype property will be available as a method to all objects created by that constructor.

  ```javascript
  var Car = function(x, y, name) {
        this.x = x;
        this.y = y;
        this.name = name;
    };

    Car.prototype.draw = function() {
        // Create a string containing HTML that points to an image of a car
        var carHtml = '<div>' + this.name +'</div>'; // 

        // Pass carHTML to the $ function, which converts it from a string to a jQuery element.
        this.carElement = $(carHtml);

        // Use the css method on carElement to set the position of the car image. 
        this.carElement.css({
            position: "absolute",
            left: this.x,
            top: this.y,
            border: '1px solid black',
            width: '100px',
            height: '40px',
            backgroundColor: '#EEE'
        });

        // Append our element to body
        $("body").append(this.carElement);
    }
    Car.prototype.moveRight = function (){
            this.x += 5;
            
            this.carElement.css({
              left: this.x,
              top: this.y
            });
    };

  // Testing the drawing Car
  var tesla = new Car(10, 20, 'Tesla');
  var nissan = new Car(100, 200, 'Nissan');

  tesla.draw();
  nissan.draw();
  ```
  
  * [Code Example](./html/carObjectPrototype.html)

### La notion de méthode:

```javascript
var perso = {
    nom: "Aurora",
    sante: 150,
    force: 25,

    // Renvoie la description du personnage
    decrire: function () {
        var description = this.nom + " a " + this.sante + " points de vie et " + this.force + " en force";
        return description;
    }
};

console.log(perso.decrire());

// Aurora est blessée par une flèche
perso.sante = perso.sante - 20;

// Aurora trouve un bracelet de force
perso.force = perso.force + 10;

console.log(perso.decrire());
```
* [Objet Creation d'un Personnage](./html/objetCreationPersonnage.html)


#### Voici une autre syntaxe possible:

```javascript
var perso = {}; 		// Création d'un objet sans aucune propriété
perso.nom = "Aurora";
perso.sante = 150;
perso.force = 25;

// Renvoie la description du personnage
perso.decrire = function () {
    var description = this.nom + " a " + this.sante + " points de vie et " + this.force + " en force";
    return description;
};
```

## Objets et prototypes en JavaScript:

```javascript
var Personnage = {
    nom: "",
    sante: 0,
    force: 0,
    xp: 0,

    // Renvoie la description du personnage
    decrire: function () {
        var description = this.nom + " a " + this.sante + " points de vie, " + this.force + " en force et " + this.xp + " points d'expérience";
        return description;
    }
};

var perso1 = Object.create(Personnage);
perso1.nom = "Aurora";
perso1.sante = 150;
perso1.force = 25;

var perso2 = Object.create(Personnage);
perso2.nom = "Glacius";
perso2.sante = 130;
perso2.force = 35;

console.log(perso1.decrire());
console.log(perso2.decrire());
```

## Initialisation:

```javascript
var Personnage = {
    // Initialise le personnage
    init: function (nom, sante, force) {
        this.nom = nom;
        this.sante = sante;
        this.force = force;
        this.xp = 0;
    },

    // Renvoie la description du personnage
    decrire: function () {
        var description = this.nom + " a " + this.sante + " points de vie, " +
            this.force + " en force et " + this.xp + " points d'expérience";
        return description;
    }
};

var perso1 = Object.create(Personnage);
perso1.init("Aurora", 150, 25);

var perso2 = Object.create(Personnage);
perso2.init("Glacius", 130, 30);

console.log(perso1.decrire());
console.log(perso2.decrire());
```

* [Compte Boncaire](./html/compte.html)
* [POO](./html/poo.html)
* [Mini Jeux](./html/MiniJeux.html)
* [POO Chiens](./html/pooChiens.html)
* [POO Compte Boncaire](./html/pooCompte.html)