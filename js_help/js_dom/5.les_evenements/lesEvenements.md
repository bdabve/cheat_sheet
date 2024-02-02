Réagissez à des événements
==========================

### Tables:

1. [Intruduction](#Introduction)
2. [La grande famille des événements](#familleEvenements)
3. [Gestion des événements les plus courants](#gestionEvenements)
4. [Aller plus loin avec les événements](#loin)
5. [En résumé](#resume)


<a name="Introduction"/>

## Introduction

### Ajout d'un gestionnaire d'événement:

* `addEventListener` : Cette méthode prend deux paramètres :

  * Le type de l'événement.
  * La fonction qui gère l'événement. Cette fonction sera appelée à chaque fois que l'événement se déclenchera sur l'élément.

  ```javascript
  function clic() {
      console.log("Clic !");
  }

  var boutonElt = document.getElementById("bouton");  
  boutonElt.addEventListener("click", clic); // Ajout d'un gestionnaire pour l'événement click

  // Une autre syntaxe
  var boutonElt = document.getElementById("bouton");  
  boutonElt.addEventListener("click", function () {
      console.log("clic"); // Ajout d'un gestionnaire pour l'événement click
  });

  ```

* OU
  
  ```html  
  <span id="clickme">Cliquez-moi !</span>
  <script>
      var element = document.getElementById('clickme');
      element.onclick = function() {
          alert("Vous m'avez cliqué !");
      };
  </script>
  ```

### Suppression d'un gestionnaire d'événement:

* `removeEventListener` : il faut que la fonction qui gère l'événement n'ait pas été définie de manière anonyme.

  ```javascript  
  boutonElt.removeEventListener("click", clic); // Suppression du gestionnaire pour l'événement click
  ```
  
* The `removeEventListener` method, called with arguments similar to `addEventListener`, removes a handler.

  ```html
  <button>Act-once button</button>
  <script>
    let button = document.querySelector("button");
    function once() {
      console.log("Done.");
      button.removeEventListener("click", once);
    }
    button.addEventListener("click", once);
  </script>
  ```  

<a name="familleEvenements"/>

## La grande famille des événements:

| Catégorie             |   Exemples
|-----------------------|-------------------------------------------------------
| Événements clavier    | Appui ou relâchement d'une touche du clavier
| Événements souris     | Clic avec les différents boutons, appui ou relâchement d'un bouton de la souris, survol d'une zone
| Événements fenêtre    | Chargement ou fermeture de la page, redimensionnement, défilement (scrolling)
| Événements formulaire | Changement de cible de saisie (focus), envoi d'un formulaire

* La plupart des propriétés de l'objet `Event` dépendent du type d'événement déclenché. Parmi les propriétés présentes dans

  * `Event`, quel que soit le type d'événement
  * `type` : envoie le type
  * `target` : renvoie la cible de l'événement, c'est-à-dire l'élément du DOM auquel l'événement est destiné.

  ```javascript
  // Ajout d'un gestionnaire qui affiche le type et la cible de l'événement
  document.getElementById("bouton").addEventListener("click", function (e) {
      console.log("Evènement : " + e.type +
          ", texte de la cible : " + e.target.textContent);
  });
  ```

<a name="gestionEvenements"/>

## Gestion des événements les plus courants

### Appui sur une touche du clavier:

* `keypress` : réagir à l'appui sur une touche du clavier, déclenchés sur le corps de la page web(variable globaledocument).

  ```javascript
  // Gestion de l'appui sur une touche du clavier produisant un caractère
  document.addEventListener("keypress", function (e) {
      console.log("Vous avez appuyé sur la touche " + String.fromCharCode(e.charCode));
  });

  // String.fromCharCode permet de traduire cette valeur en une chaîne représentant le caractère.
  ```

* Pour gérer l'appui et le relâchement sur n'importe quelle touche du clavier (pas seulement celles qui produisent des caractères), on utilise les événements `keydown` et `keyup`.
  
  ```javascript
  // Affiche des informations sur un événement clavier
  function infosClavier(e) {
      console.log("Evènement clavier : " + e.type + ", touche : " + e.keyCode);
  }

  // Gestion de l'appui et du relâchement d'une touche du clavier
  document.addEventListener("keydown", infosClavier);
  document.addEventListener("keyup", infosClavier);
  ```

### Clic sur un bouton de la souris:

* Le clic souris sur n'importe quel élément du DOM déclenche l'apparition d'un événement de type `click`.
L'objet Event associé à un événement de type click contient (entre autres) une propriété button qui permet de connaître le bouton de la souris utilisé, ainsi que des propriétés clientX et clientY qui renvoient les coordonnées horizontales et verticales de l'endroit où le clic s'est produit.

  ```javascript
  // Renvoie le nom du bouton souris à partir de son code
  function getBoutonSouris(code) {
      var bouton = "inconnu";
      switch (code) {
      case 0:                     // 0 est le code du bouton gauche
          bouton = "gauche";
          break;
      case 1:                     // 1 est le code du bouton du milieu
          bouton = "milieu";
          break;
      case 2:                     // 2 est le code du bouton droit
          bouton = "droit";
          break;
      }
      return bouton;
  }

  // Affiche des informations sur un événement souris
  function infosSouris(e) {
      console.log("Evènement souris : " + e.type + ", bouton " +
          getBoutonSouris(e.button) + ", X : " + e.clientX + ", Y : " + e.clientY);
  }

  // Gestion du clic souris
  document.addEventListener("click", infosSouris);
  ```

* On peut utiliser les événements `mousedown` et `mouseup` pour détecter l'appui et le relâchement d'un bouton de la souris.

  ```javascript
  // Gestion de l'appui et du relâchement d'un bouton de la souris
  document.addEventListener("mousedown", infosSouris);
  document.addEventListener("mouseup", infosSouris);
  ```

* Un autre example

  ```javascript
  <button>Click me</button>
  <p>No handler here.</p>
  <script>
    let button = document.querySelector("button");
    button.addEventListener("click", () => {
        console.log("Button clicked.");
    });
  </script>
  ```

### Fin du chargement de la page web:

* Il est possible de détecter la fin du chargement de la page en ajoutant un gestionnaire pour l'événement `load` sur l'objet `window`, qui représente la fenêtre du navigateur. Cela permet d'éviter d'interagir via JavaScript avec des parties de la page non encore chargées.

  ```javascript
  // Gestion de la fin du chargement de la page web
  window.addEventListener("load", function () {
      console.log("Page entièrement chargée");
  });
  ```

### Fermeture de la page web:

* On peut parfois vouloir détecter la fermeture d'une page web, qui se produit lorsque l'utilisateur ferme l'onglet qui l'affiche ou navigue vers une autre page dans cet onglet. Un cas d'utilisation fréquent consiste à afficher une demande de confirmation.

  ```javascript
  // Gestion de la fermeture de la page web
  window.addEventListener("beforeunload", function (e) {
      var message = "On est bien ici !";
      e.returnValue = message; // Provoque une demande de confirmation (standard)
      return message; // Provoque une demande de confirmation (certains navigateurs)
  });
  ```

---

## Default actions

* Many events have a default action associated with them. If you click a link, you will be taken to the link’s target. If you press the down arrow, the browser will scroll the page down. If you right-click, you’ll get a context menu. And so on.

* If the handler doesn’t want this normal behavior to happen, typically because it has already taken care of handling the event, it can call the `preventDefault` method on the event object.

  ```javascript
  <a href="https://developer.mozilla.org/">MDN</a>
  <script>
    let link = document.querySelector("a");
    link.addEventListener("click", event => {
      console.log("Nope.");
      event.preventDefault();
    });
  </script>
  ```
---

<a name="loin"/>

## <center>Aller plus loin avec les événements</center>

### Comprendre la propagation des événements:
* Le DOM représente une page web sous la forme d'une hiérarchie de noeuds. Les événements déclenchés sur un noeud enfant vont se déclencher ensuite sur son noeud parent, puis sur le parent de celui-ci, et ce jusqu'à la racine du DOM (la variable document). C'est ce qu'on appelle la propagation des événements.

* La propagation des événements peut être interrompue à tout moment en appelant la méthode `stopPropagationsur` l'objet `Event` depuis une fonction qui gère un événement. C'est utile pour éviter qu'un même événement soit géré plusieurs fois.

  ```javascript
  // Gestion du clic sur le bouton
  document.getElementById("propa").addEventListener("click", function (e) {
      console.log("Gestionnaire bouton");
      e.stopPropagation(); // Arrêt de la propagation de l'événement
  });

  ```

### Modifier le comportement par défaut en cas d'événement

* La plupart des événements sont associés à une action par défaut. Le clic sur un lien déclenche la navigation vers la cible de ce lien, le clic avec le bouton droit de la souris affiche un menu contextuel, etc. Il est possible d'annuler ce comportement par défaut en appelant la méthode `preventDefaultsur` l'objet `Event`.

  ```javascript
  // Gestion du clic sur le lien interdit
  document.getElementById("interdit").addEventListener("click", function (e) {
      console.log("Continuez plutôt à lire le cours ;)");
      e.preventDefault(); // Annulation de la navigation vers la cible du lien
  });
  ```

## Events and when they are triggered:

| Event | Occurs |
|:------:|:--------|
| `onabort`| When an image's loading is stopped before completion |
| `onblur` | When an element loses focus |
| `onchange` | When any part of a form has chaged |
| `onclick` | When an object is clicked |
| `ondblclick` | When an object is double-clicked
| `onerror` | When a JavaScript error is encountered
| `onfocus` | When an element gets focus
| `onkeydown` | When a key is being pressed (including Shift, Alt, Ctrl, and Esc)
| `onkeypress` | When a key is being pressed (not including Shift, Alt, Ctrl, and Esc)
| `onkeyup` | When a key is released
| `onload` | When an object has loaded
| `onmousedown` | When the mouse button is pressed over an element
| `onmousemove` | When the mouse is moved over an element
| `onmouseout` | When the mouse leaves an element
| `onmouseover` | When the mouse passes over an element from outside it
| `onmouseup` | When the mouse button is released
| `onsubmit` | When a form is submitted
| `onreset` | When a form is reset
| `onresize` | When the browser is resized
| `onscroll` | When the document is scrolled
| `onselect` | When some text is selected
| `onunload` | When a document is removed

* [Course Example](./html/cours.html)
* [Compteur click](./html/compteurClick.html)
* [Couleurs](./html/couleurs.html)
* [Desserts](./html/desserts.html)
* [Quiz](./html/quiz.html)
