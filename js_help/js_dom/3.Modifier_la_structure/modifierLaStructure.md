## Modifiez la structure de la page:

### Modifier un élément existant:

* `innerHTML`: peut être utilisée pour modifier le contenu HTML d'un élément du DOM.

* `innerHTML` est souvent employée pour "vider" un élément de tout son contenu.

  ```javascript
  // Modification du contenu HTML de la liste : ajout d'un langage
  document.getElementById("langages").innerHTML += '<li id="c">C</li>';

  // Suppression du contenu HTML de la liste
  document.getElementById("langages").innerHTML = "";
  ```

* `textContent`: permet de modifier le contenu textuel d'un élément du DOM.

  ```javascript
  // Modification du contenu textuel du premier titre
  document.querySelector("h1").textContent += " de programmation";
  ```

* `setAttribute`: permet de définir la valeur de l'un des attributs d'un élément. Elle prend en paramètres le nom et la valeur de cet attribut.

* Certains attributs comme `id`, `href` et `value` sont directement modifiables sous la forme de propriétés.

  ```javascript
  // Définition de l'attribut "id" du premier titre
  document.querySelector("h1").setAttribute("id", "titre");
  document.querySelector("h1").id = "titre";                  // équivallant au premier
  ```

* `classList`: pour ajouter ou supprimer des classes à un élément du DOM.

  ```javascript
  var titreElt = document.querySelector("h1"); // Accès au premier titre h1
  titreElt.classList.remove("debut"); // Suppression de la classe "debut"
  titreElt.classList.add("titre"); // Ajout de la classe "titre"
  console.log(titreElt);
  ```

## Ajouter un nouvel élément:

* L'ajout d'un nouvel élément à une page web peut se décomposer en trois opérations :
  * Création du nouvel élément.
  * Définition des informations de l'élément.
  * Insertion du nouvel élément dans le DOM.

  ```javascript
  var rubyElt = document.createElement("li"); // Création d'un élément li
  rubyElt.id = "ruby"; // Définition de son identifiant
  rubyElt.textContent = "ruby"; // Définition de son contenu textuel
  document.getElementById("langages").appendChild(rubyElt); // Insertion du nouvel élément
  ```

## <center>Variantes pour ajouter un élément</center>

#### Création d'un noeud textuel:

  ```javascript
  var perlElt = document.createElement("li"); // Création d'un élément li
  perlElt.id = "perl"; // Définition de son identifiant

  perlElt.appendChild(document.createTextNode("Perl")); // Définition de son contenu textuel
  document.getElementById("langages").appendChild(perlElt); // Insertion du nouvel élément
  ```

#### Ajout d'un noeud avant un autre noeud:

* `insertBefore`: On l'appelle sur le futur élément parent et on lui passe en paramètres le nouveau noeud ainsi que le noeud avant lequel le nouveau noeud sera inséré.
  
  ```javascript
  var bashElt = document.createElement("li"); // Création d'un élément li
  bashElt.id = "bash"; // Définition de son identifiant
  bashElt.textContent = "Bash"; // Définition de son contenu textuel

  // Ajout du nouvel élément avant l'identifiant identifié par "php"

  document.getElementById("langages").insertBefore(bashElt,
      document.getElementById("php"));
  
  // insert after php
  document.getElementById("langages").insertAfter(bashElt,
      document.getElementById("php"));

  ```

#### Choix de la position exacte du nouveau noeud:

* Il existe une méthode plus récente qui permet de définir encore plus précisément la position des éléments insérés 
* `insertAdjacentHTML`: On l'appelle sur un élément existant et elle prend en paramètres une position et une chaîne de caractères HTML qui représente le nouveau contenu à ajouter. 
* La position du nouveau contenu doit être une valeur parmi :

  * `beforebegin`: avant l'élément existant lui-même.
  * `afterbegin`: juste à l'intérieur de l'élément existant, avant son premier enfant.
  * `beforeend`: juste à l'intérieur de l'élément existant, après son dernier enfant.
  * `afterend`: après l'élément existant lui-même.

  ```javascript
  // Ajout d'un élément au tout début de la liste en HTML
  document.getElementById('langages').insertAdjacentHTML("afterBegin", '<li id="javascript">JavaScript</li>');

  // Ajout d'un élément au tout début de la liste aprés creation
  document.getElementById('langages').insertAdjacentElement("afterBegin", element);
  ```

## Remplacer, cloner ou supprimer un noeud:

* Remplacer un noeud existant

  ```javascript
  var zshElt = document.createElement("li"); // Création d'un élément li
  zshElt.id = "zsh"; // Définition de son identifiant
  zshElt.textContent = "Zsh"; // Définition de son contenu textuel

  // Remplacement de l'élément identifié par "bash" par le nouvel élément
  document.getElementById("langages").replaceChild(zshElt, document.getElementById("bash"));
  ```

* Supprimer un noeud existant:

  ```javascript
  // Suppression de l'élément identifié par "bash"

  document.getElementById("langages").removeChild(document.getElementById("bash"));
  ```

* Cloner un element

  * Pour cloner un élément, rien de plus simple `cloneNode()`. 
  * Cette méthode requiert un paramètre booléen `true` ou `false` : si vous désirez cloner le nœud avec (true) ou sans (false) ses enfants et ses différents attributs.
  
  ```javascript
  // On va cloner un élément créé :
  var hr1 = document.createElement('hr');
  var hr2 = hr1.cloneNode(false); // Il n'a pas d'enfants…

  // Ici, on clone un élément existant :
  var paragraph1 = document.getElementById('myP');
  var paragraph2 = paragraph1.cloneNode(true);

  // Et attention, l'élément est cloné, mais pas « inséré » tant que l'on n'a pas appelé appendChild() :
  paragraph1.parentNode.appendChild(paragraph2);
  ```

* [Course Example](./html/cours.html)
* [Add Elements Example](./html/addingElements.html)
* [Dictionnaire Example](./html/dictionnaire.html)
* [Journaux Example](./html/journaux.html)
* [Crée du texte mélangé à divers éléments](./html/textMelangeAplusieurBalise.html)
* [Crér Plusieur li](./html/plusieurLi.html)