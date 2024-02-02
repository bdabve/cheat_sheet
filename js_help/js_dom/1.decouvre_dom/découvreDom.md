## Introduction au DOM:

* Document Object Model

* Le DOM définit la structure d'une page et le moyen d'interagir avec elle : il s'agit d'une interface de programmation, ou API (Application Programming Interface).


## Premiers pas avec le DOM en JavaScript:

* Le DOM représente une page web sous la forme d'une hiérarchie d'objets, où chaque objet correspond à un nœud de l'arborescence de la page. Les objets du DOM disposent de propriétés et de méthodes permettant de les manipuler avec JavaScript.

### Accéder au DOM:

* La variable `document` correspond à l'élément `<html>`.

```javascript
var h = document.head; // La variable h contient l'objet head du DOM
console.log(h);

var b = document.body; // La variable b contient l'objet body du DOM
console.log(b);
```

### Découvrir le type d'un nœud:

* Chaque objet du DOM a une propriété `nodeType` qui indique son type. La valeur de cette propriété est 
  * `document.ELEMENT_NODE`:  pour un nœud "élément" (balise HTML)
  * `document.TEXT_NODE` : pour un nœud textuel.

  ```javascript
  if (document.body.nodeType === document.ELEMENT_NODE) {
      console.log("Body est un noeud élément");
  } else {
      console.log("Body est un noeud textuel");
  }
  ```

#### Accéder aux enfants d'un noeud élément:

* Chaque objet du DOM de type élément possède une propriété `childNodes`. Il s'agit d'une collection ordonnée regroupant tous ses nœuds enfants sous la forme d'objets DOM.

  ```javascript
  // Accès au premier enfant du noeud body
  console.log(document.body.childNodes[0]);
  ```

* les espaces entre les balises ainsi que les retours à la ligne dans le code HTML sont considérés par le navigateur comme des noeus textuels.

#### Parcourir la liste des nœuds enfants:

 ```javascript
// Affiche les noeuds enfant du noeud body
for (var i = 0; i < document.body.childNodes.length; i++) {
    console.log(document.body.childNodes[i]);
}
 ```

#### Accéder au parent d'un nœud

```javascript
var h1 = document.body.childNodes[1];
console.log(h1.parentNode); // Affiche le noeud body

console.log(document.parentNode); // Affiche null : document n'a aucun noeud parent
```
