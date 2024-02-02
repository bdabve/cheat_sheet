// Selection d'elements selon leur balise

var titresElts = document.getElementsByTagName("h2");   // Tous les titres h2
console.log(titresElts[0]);         // Affiche le premier titre h2
console.log(titresElts.length);     // Affiche 3

// Sélection d'éléments selon leur classe:
// Tous les elements ayant la class merveilles:
var merveillesElts = document.getElementsByClassName("merveilles");
for (var i = 0; i < merveillesElts.length; i++){
    console.log(merveillesElts[i]);
}

// Sélection d'un élément selon son identifiant
// Elément portant l'identifiant "nouvelles"
console.log(document.getElementById("nouvelles"))

// Sélection d'éléments à partir d'un sélecteur CSS:
// tous les paragraphes
console.log("\n\n")
console.log(document.querySelectorAll("p").length);     // Affiche 3

// tous les paragraphes à l'intérieur de l'élément identifié par "contenu"
console.log(document.querySelectorAll("#contenu p").length);       // Affiche 2

// tous les éléments ayant la classe "existe"
console.log(document.querySelectorAll(".existe").length);       // affiche 8

// tous les éléments fils de l'élément identifié par "antiques" ayant la classe "existe"
console.log(document.querySelectorAll("#antiques > .existe").length);      // Affiche 1

// le premier paragraphe avec querySelector
console.log(document.querySelector("p"));


// Le contenu HTML de l'élément identifié par "contenu"
console.log(document.getElementById("contenu").innerHTML);

// L'attribut href du premier lien
console.log(document.querySelector("a").getAttribute("href"));

// l'identifiant de la première liste
console.log(document.querySelector("ul").id);
// l'attribut href du premier lien
console.log(document.querySelector("a").href)

// Vérifié la présence d'un attribut sur un élément.
if (document.querySelector("a").hasAttribute("target")) {
    console.log("Le premier lien possède l'attribut target");
} else {
    console.log("Le premier lien ne possède pas l'attribut target");
}


// Liste des classes de l'élément identifié par "antiques"
var classes = document.getElementById("antiques").classList;
console.log(classes.length); // Affiche 1 : l'élément possède une seule classe
console.log(classes[0]); // Affiche "merveilles"

// Tester la présence d'une classe dans un élément
if (document.getElementById("antiques").classList.contains("merveille")) {
    console.log("L'élément identifié par antiques possède la classe merveille");
} else {
    console.log("L'élément identifié par antiques ne possède pas la classe merveille");
}
