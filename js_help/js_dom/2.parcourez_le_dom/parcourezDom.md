# <center>Parcourez le DOM</center>

### Selection d'elements selon leur balise

* `getElementsByTagName`: Renvoie une liste des éléments qui portent le nom de la balise qui a été passée en paramètre lors de l'appel.

  ```javascript
  var titresElts = document.getElementsByTagName("h2");   // Tous les titres h2
  console.log(titresElts[0]);                             // Affiche le premier titre h2
  console.log(titresElts.length);                         // Affiche 3
  ```

### Sélection d'éléments selon leur classe:

* `getElementsByClassName`: Elle renvoie une liste des éléments ayant le nom de classe passé en paramètre. Là encore, la recherche concerne l'ensemble des sous-éléments du nœud sur laquelle la méthode est appelée.

  ```javascript
  // Tous les elements ayant la class merveilles:

  var merveillesElts = document.getElementsByClassName("merveilles");
  for (var i = 0; i < merveillesElts.length; i++){
      console.log(merveillesElts[i]);
  }
  ```

### Sélection d'un élément selon son identifiant

* `getElementById`: Renvoie parmi tous ses sous-éléments celui possédant l'identifiant passé en paramètre.

  ```javascript
  // Elément portant l'identifiant "nouvelles"

  console.log(document.getElementById("nouvelles"))
  ```

### Sélection d'éléments à partir d'un sélecteur CSS:

* `querySelectorAll`: Permet de rechercher des éléments à partir d'un sélecteur CSS.

  ```javascript
  // Tous les paragraphes
  console.log("\n\n")
  console.log(document.querySelectorAll("p").length);     // Affiche 3

  // Tous les paragraphes à l'intérieur de l'élément identifié par "contenu"
  console.log(document.querySelectorAll("#contenu p").length);       // Affiche 2

  // Tous les éléments ayant la classe "existe"
  console.log(document.querySelectorAll(".existe").length);       // affiche 8

  // Tous les éléments fils de l'élément identifié par "antiques" ayant la classe "existe"
  console.log(document.querySelectorAll("#antiques > .existe").length);      // Affiche 1
  ```

* `querySelector`: Elle fonctionne de manière identique à `querySelectorAll`, mais renvoie uniquement le premier élément correspondant au sélecteur passé en paramètre.

  ```javascript
  // le premier paragraphe avec querySelector
  console.log(document.querySelector("p"));
  ```

### Adopter une approche pragmatique présentée dans le tableau

|  Nombre d'éléments à obtenir | Critère de Sélection               |   Méthode à utiliser
|------------------------------|------------------------------------|-----------------------
| Plusieurs                    | Par balise                         | `getElementsByTagName`
| Plusieurs                    | Par classe                         | `getElementsByClassName`
| Plusieurs                    | Autre que par balise ou par classe | `querySelectorAll`
| Un seul                      | Par identifiant                    | `getElementById`
| Un seul (le premier)         | Autre que par identifiant          | `querySelector`


***

## <center>Obtenir des informations sur les éléments</center>

### Le contenu HTML:

* `innerHTML`: Permet de récupérer tout le contenu HTML d'un élément du DOM.

  ```javascript
  // Le contenu HTML de l'élément identifié par "contenu"
  console.log(document.getElementById("contenu").innerHTML);
  ```

### Le contenu Textuel

* `textContent` renvoie tout le contenu textuel d'un élément du DOM, sans l'éventuel balisage HTML.

  ```javascript
  // Le contenu textuel de l'élément identifié par "contenu"
  console.log(document.getElementById("contenu").textContent);
  ```

### Les attributs:
* `getAttribute`: Peut être appliquée à un élément du DOM et renvoie la valeur de l'attribut passé en paramètre.

  ```javascript
  // L'attribut href du premier lien
  console.log(document.querySelector("a").getAttribute("href"));
  ```

* Certains attributs sont directement accessibles sous la forme de propriétés. C'est notamment le cas pour les attributs id, href et value.

  ```javascript
  // L'identifiant de la première liste
  console.log(document.querySelector("ul").id);

  // L'attribut href du premier lien
  console.log(document.querySelector("a").href);
  ```

* `hasAttribute`: Vérifier la présence d'un attribut sur un élément

  ```javascript
  if (document.querySelector("a").hasAttribute("target")) {
      console.log("Le premier lien possède l'attribut target");
  } else {
      console.log("Le premier lien ne possède pas l'attribut target");
  }
  ```

### Les classes

* `classList` permet de récupérer la liste des classes d'un élément du DOM. Elle s'utilise comme un tableau.

  ```javascript
  // Liste des classes de l'élément identifié par "antiques"
  var classes = document.getElementById("antiques").classList;
  console.log(classes.length); // Affiche 1 : l'élément possède une seule classe
  console.log(classes[0]); // Affiche "merveilles"
  ```

* `contains`: Tester la présence d'une classe dans un élément

  ```javascript
  if (document.getElementById("antiques").classList.contains("merveille")) {
      console.log("L'élément identifié par antiques possède la classe merveille");
  } else {
      console.log("L'élément identifié par antiques ne possède pas la classe merveille");
  }
  ```
  
* [Course Example](./html/cours.html)
* [Exemple 1](./html/instruments.html)
* [Example 2](./html/reve.html)

## The OSC function

* For handling DOM elements and CSS styles quickly and efficiently, without the need for including a framework such as `jQuery`.

* `O() function`: Saves 22 characters of typing each time it's called. To select by id

  ```javascript
  function O(i)
  {
    return typeof i == 'object' ? i : document.getElementById(i)
  }  
  ```
  > If an object is passed to the function, it just returns tha object back again, Otherwise, it assumes that an ID is passed and returns the object to which the ID refers.
  
* `S() function`: Gives you easy access to the `style` properties of an object

  ```javascript
  function S(i)
  {
    return O(i).style
  }  
  ```
  > The function performs the task of returning the `style` property of the element referred to.

  ```javascript
  <div id='myobj'>Some Text</div>
  <script>
    O('myobj').style.color = 'green';
  </script>

  // With the S Function
  S('myobj').color = 'green';

  // 
  fred = O('myobj');
  S(fred).color = 'green';
  ```

* `C() function`: Accessing a class name.

  ```javascript
  function C(i)
  {
    return document.getElementByClassName(i);
  }  
  ```

  ```javascript
  myarray = C('myclass');
  ```

* You can save the three function in file OSC.js and call it in you HTML file like: `<script src="OSC.js"></script>`.
* The content of OSC:

  ```javascript
  function O(i){ return tyeof i == 'object' ? i : document.getelementById(i) } 
  function S(i){ return O(i).style } 
  function C(i){ return document.getelementByClassName(i) } 
  ```
