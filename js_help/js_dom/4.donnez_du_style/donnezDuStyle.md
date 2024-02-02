# <center>Donnez du style à vos éléments</center>


## Modifier le style d'un élément:

* `style` : Renvoie un objet représentant l'attribut style de l'élément. 
  
* Les propriétés de cet objet correspondent aux propriétés `CSS` de l'élément. 
* En définissant leur valeur depuis `JavaScript`, on modifie le style de l'élément.

  ```javascript
  var pElt = document.querySelector("p");
  pElt.style.color = "red";
  pElt.style.margin = "50px";
  ```

* Les propriétés CSS composées:

  * Certaines propriétés CSS s'écrivent sous la forme d'un nom composé.  
  * Pour utiliser ces propriétés en JavaScript, il faut supprimer le tiret et écrire la première lettre du mot suivant en majuscule.

  ```javascript
  // ...
  pElt.style.fontFamily = "Arial";
  pElt.style.backgroundColor = "black";
  ```
* La liste des principales propriétés CSS et leurs équivalents JS est consultable à [cette adresse](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Properties_Reference).

## Accéder au style d'un élément:

* La propriété `style` utilisée en JS représente l'attribut style de l'élément. Elle ne permet pas d'accéder aux déclarations de style situées ailleurs, par exemple dans une feuille de style CSS externe.

  ```javascript
  var paragraphesElts = document.getElementsByTagName("p");
  console.log(paragraphesElts[0].style.color); // Affiche "red"
  console.log(paragraphesElts[1].style.color); // Affiche "green"
  console.log(paragraphesElts[2].style.color); // N'affiche rien
  ```

* Pour accéder au style d'un élément consiste à utiliser une fonction nommée  `getComputedStyle`. 
* `getComputedStyle`: Elle prend en paramètre un noeud du DOM et renvoie un objet représentant son style. On peut ensuite consulter les différentes propriétés CSS de cet objet.

  ```javascript
  var stylePara = getComputedStyle(document.getElementById("para"));
  console.log(stylePara.fontStyle); // Affiche "italic"
  console.log(stylePara.color); // Affiche la couleur bleue en valeurs RGB
  ```

* [Course Example](./html/cours.html)
* [Couleurs Example](./html/couleurs.html)
* [Infos Example](./html/infos.html)