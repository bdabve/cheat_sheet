Manipulez les formulaires
=========================

### Tables:
1. [Les zones de texte](#texte)
2. [Les éléments d'options](#option)
3. [Le formulaire comme élément du DOM](#formulaireElementDom)
4. [Validation des données saisies](#validation)

<a name="texte"/>

## Les zones de texte:

* Accès à la valeur saisie:

  * Une zone monoligne correspond à la balise HTML `<input type="text">`.

  * Une zone multiligne est définie grâce à la balise `<textarea>`.

    ```javascript
    // on accède à la valeur d'une zone de texte en utilisant la propriété value
    var pseudoElt = document.getElementById("pseudo");
    pseudoElt.value = "MonPseudo";
    ```

### Gestion du focus:

* Lorsqu'une zone de texte est la cible de saisie, on dit que cette zone possède le `focus`.   
* L'utilisateur d'un formulaire qui clique sur une zone de saisie pour y taper une information déclenche l'apparition d'un événement de type `focus`.
* Inversement,  le changement de cible de saisie provoque l'apparition d'un événement de type `blur` sur l'ancienne zone qui avait le focus.
* On peut utiliser ces événements pour afficher à l'utilisateur une aide contextuelle associée à la zone de saisie courante, comme dans l'exemple suivant.

  ```javascript
  // Affichage d'un message contextuel pour la saisie du pseudo
  pseudoElt.addEventListener("focus", function () {
      document.getElementById("aidePseudo").textContent = "Entrez votre pseudo";
  });

  // Une autre methode
  var text = document.getElementById('text');

  text.addEventListener('focus', function(e) {
      e.target.value = "Vous avez le focus !";
  });

  text.addEventListener('blur', function(e) {
      e.target.value = "Vous n'avez pas le focus !";
  });

  // Suppression du message contextuel pour la saisie du pseudo
  pseudoElt.addEventListener("blur", function (e) {
      document.getElementById("aidePseudo").textContent = "";
  });
  ```

<a name="option"/>

## Les éléments d'options:

* Ces éléments permettent à l'utilisateur de faire un choix parmi plusieurs possibilités.   
* Ils ont en commun de déclencher un événement de type `change` lorsque l'utilisateur modifie son choix.
* Cases à cocher: On définit une case à cocher dans un formulaire avec la balise `<input type="checkbox">`.

  ```javascript
  // Affichage de la demande de confirmation d'inscription
  document.getElementById("confirmation").addEventListener("change", function (e) {
      console.log("Demande de confirmation : " + e.target.checked);
  });

  // Un autre example
  function check() {
        var inputs = document.getElementsByTagName('input'),    // get all inputs
            inputsLength = inputs.length;

        for (var i = 0; i < inputsLength; i++) {  // iterate throug all our input and get checked input value
            if (inputs[i].type === 'radio' && inputs[i].checked) {
                alert('La case cochée est la n°' + inputs[i].value);
            }
        }
    }
  // Avec querySelectorAll 
  function check() {
    var inputs = document.querySelectorAll('input[type=radio]:checked'),
        inputsLength = inputs.length;

    for (var i = 0; i < inputsLength; i++) {
        alert('La case cochée est la n°' + inputs[i].value);
    }
  }
  ```

### Boutons radio:

* Un groupe de boutons radio permet à l'utilisateur de faire un seul choix parmi plusieurs possibilités.  
* On crée ces boutons avec des balises `<input type="radio">` possédant le même attributnameet des attributs `value` différents.

  ```javascript
  // Affichage du type d'abonnement choisi
  var aboElts = document.getElementsByName("abonnement");
  for (var i = 0; i < aboElts.length; i++) {
      aboElts[i].addEventListener("change", function (e) {
          console.log("Formule d'abonnement choisie : " + e.target.value);
      });
  }
  ```

###  Listes déroulantes:

* On construit une liste déroulante au moyen d'une balise `<select>` dans laquelle on ajoute une balise `<option>` par choix possible dans la liste.
* `selectedIndex`: qui nous donne l'index de la valeur sélectionnée.
* `options`: qui liste dans un tableau les éléments `<option>` de notre liste déroulante.

  ```javascript
  // Affichage du code de nationalité choisi
  document.getElementById("nationalite").addEventListener("change", function (e) {
      console.log("Code de nationalité : " + e.target.value);
  });

  // Avec selectIndex and option
  var list = document.getElementById('list');
  list.addEventListener('change', function() {
      // On affiche le contenu de l'élément <option> ciblé par la propriété selectedIndex
      alert(list.options[list.selectedIndex].innerHTML);

  });
  ```


<a name="formulaireElementDom"/>

## Le formulaire comme élément du DOM

* La balise `<form>` définissant un formulaire correspond à un élément du DOM. 
  
* Cet élément possède une propriété `elements` rassemblant les champs de saisie du formulaire. 
  
* On peut l'utiliser pour accéder à un champ à partir de son nom `attribut name` ou à partir de son indice dans (ordre d'apparition dans le formulaire).

  ```javascript
  var form = document.querySelector("form");
  console.log("Nombre de champs de saisie : " + form.elements.length); // Affiche 10
  console.log(form.elements[0].name); // Affiche "pseudo"
  console.log(form.elements.mdp.type); // Affiche "password"
  ```

* Soumission du formulaire

* Un formulaire est soumis lorsque l'utilisateur clique sur le bouton d'envoi. 
  
  * Ce bouton correspond à une balise `<input type="submit">`. 
  
  * Une balise `<input type="reset">` affiche un bouton qui réinitialise les données du formulaire.
    
    ```javascript
    var element = document.getElementById('un_id_de_formulaire');

    element.submit(); // Le formulaire est expédié
    element.reset();  // Le formulaire est réinitialisé
    ```

* L'exemple de code ci-dessous affiche dans la console l'ensemble des informations saisies ou choisies par l'utilisateur, puis utilise la méthode `preventDefault` pour annuler l'envoi des données du formulaire.

  ```javascript
  // Affiche de toutes les données saisies ou choisies
  form.addEventListener("submit", function (e) {
      var pseudo = form.elements.pseudo.value;
      var mdp = form.elements.mdp.value;
      var courriel = form.elements.courriel.value;
      console.log("Vous avez choisi le pseudo " + pseudo + ", le mot de passe " +
          mdp + " et le courriel " + courriel);
      if (form.elements.confirmation.checked) {
          console.log("Vous avez demandé une confirmation d'inscription par courriel");
      } else {
          console.log("Vous n'avez pas demandé de confirmation d'inscription par courriel");
      }
      switch (form.elements.abonnement.value) {
      case "abonewspromo":
          console.log("Vous êtes abonné(e) à la newsletter et aux promotions");
          break;
      case "abonews":
          console.log("Vous êtes abonné(e) à la newsletter");
          break;
      case "aborien":
          console.log("Vous n'êtes abonné(e) à rien");
          break;
      default:
          console.log("Erreur : code d'abonnement non reconnu");
      }
      switch (form.elements.nationalite.value) {
      case "FR":
          console.log("Vous êtes français(e)");
          break;
      case "BE":
          console.log("Vous êtes belge");
          break;
      case "SUI":
          console.log("Vous êtes suisse");
          break;
      default:
          console.log("Erreur : code de nationalité non reconnu");
      }
      e.preventDefault(); // Annulation de l'envoi des données
  });
  ```

<a name="validation"/>

## Validation des données saisies

* Contrôler les données saisies par l'utilisateur avant de les envoyer à un serveur est l'un des grands intérêts de l'utilisation de JavaScript avec les formulaires web. 
  
* Ainsi, on peut signaler immédiatement d'éventuelles erreurs de saisie, ce qui améliore l'expérience de l'utilisateur. On évite également des allers-retours réseau coûteux en temps.

* Le contrôle de validité peut se faire de plusieurs manières, éventuellement combinables :

* Validation pendant la saisie:

  ```javascript
  // Vérification de la longueur du mot de passe saisi
  document.getElementById("mdp").addEventListener("input", function (e) {
      var mdp = e.target.value; // Valeur saisie dans le champ mdp
      var longueurMdp = "faible";
      var couleurMsg = "red"; // Longueur faible => couleur rouge
      if (mdp.length >= 8) {
          longueurMdp = "suffisante";
          couleurMsg = "green"; // Longueur suffisante => couleur verte
      } else if (mdp.length >= 4) {
          longueurMdp = "moyenne";
          couleurMsg = "orange"; // Longueur moyenne => couleur orange
      }
      var aideMdpElt = document.getElementById("aideMdp");
      aideMdpElt.textContent = "Longueur : " + longueurMdp; // Texte de l'aide
      aideMdpElt.style.color = couleurMsg; // Couleur du texte de l'aide
  });
  ```

* Validation à la fin de la saisie:

  ```javascript
  // Contrôle du courriel en fin de saisie
  document.getElementById("courriel").addEventListener("blur", function (e) {
      var validiteCourriel = "";
      if (e.target.value.indexOf("@") === -1) {
          // Le courriel saisi ne contient pas le caractère @
          validiteCourriel = "Adresse invalide";
      }
      document.getElementById("aideCourriel").textContent = validiteCourriel;
  });
  ```

* Avec REGEX:

  ```javascript
  // Contrôle du courriel en fin de saisie
  document.getElementById("courriel").addEventListener("blur", function (e) {
      // Correspond à une chaîne de la forme xxx@yyy.zzz
      var regexCourriel = /.+@.+\..+/;
      var validiteCourriel = "";
      if (!regexCourriel.test(e.target.value)) {
          validiteCourriel = "Adresse invalide";
      }
      document.getElementById("aideCourriel").textContent = validiteCourriel;
  });
  ```

* [Course Example](./html/cours.html)
* [Validate Form Example](./html/validateForm.html)
* [Maisons et personnages](./html/got.html)
* [Vérification de mots de passe](./html/mdp.html)
* [Aide au choix d'un pays](./html/pays.html)
* [Check All Input](./html/checkAllInput.html)
* [Verifier 2 champ pour la meme valeur](./html/verifierTwoEmail.html)
* [Editer Un Tableaux on Clicking on cells](./html/editerUnTableau.html)
