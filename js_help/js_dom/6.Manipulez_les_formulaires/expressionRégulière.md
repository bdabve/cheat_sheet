expression régulière
====================

```javascript
var regex = /@/;                                // La chaîne doit contenir le caractère @
console.log(regex.test(""));                    // Affiche false
console.log(regex.test("@"));                   // Affiche true
console.log(regex.test("sophie&mail.fr"));      // Affiche false
console.log(regex.test("sophie@mail.fr"));      // Affiche true
```

* On définit une expression régulière JavaScript en plaçant son motif entre deux caractères /. 
  
  La variable ainsi créée est un objet. Sa méthode `test` détecte la présence d'une correspondance avec le motif dans la chaîne de caractères passée en paramètre, et renvoie `true` ou `false` selon le cas.

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
