// Modification du contenu HTML de la liste : ajout d'un langage
document.getElementById("langages").innerHTML += '<li id="python">Python</li>';


// Suppression du contenu HTML de la liste
// document.getElementById("langages").innerHTML = "";


// Modification du contenu textuel du premier titre
document.querySelector("h1").textContent += " de programation";

// Définition de l'attribut "id" du premier titre
document.querySelector("h1").setAttribute("id", "titre");
document.querySelector("h1").id = "titre";


// Ajout de nouvelle elements.
var titreElt = document.querySelector("h1");    // Accès au premier titre h1
titreElt.classList.remove("debut");             // Suppression de la classe "debut"
titreElt.classList.add("titre");                // Ajout de la classe "titre"
console.log(titreElt);


var rubyElt = document.createElement("li");                 // Création d'un élément li
rubyElt.id = "ruby";                                        // Définition de son identifiant
rubyElt.textContent = "Ruby";                               // Définition de son contenu textuel
document.getElementById("langages").appendChild(rubyElt);   // Insertion du nouvel élément

var perlElt = document.createElement("li");                 // Création d'un élément li
perlElt.id = "perl";                                        // Définition de son identifiant
perlElt.appendChild(document.createTextNode("Perl"));       // Définition de son contenu textuel
document.getElementById("langages").appendChild(perlElt);   // Insertion du nouvel élément

var bashElt = document.createElement("li");             // Création d'un élément li
bashElt.id = "bash";                                    // Définition de son identifiant
bashElt.textContent = "Bash";                           // Définition de son contenu textuel
// Ajout du nouvel élément avant l'identifiant identifié par "php"
document.getElementById("langages").insertBefore(bashElt,
    document.getElementById("php"));


// Ajout d'un élément au tout début de la liste
document.getElementById('langages').insertAdjacentHTML("afterBegin",
    '<li id="javascript">JavaScript</li>');


// Remplacement
var zshElt = document.createElement("li");  // Création d'un élément li
zshElt.id = "zsh";                          // Définition de son identifiant
zshElt.textContent = "Zsh";                 // Définition de son contenu textuel
// Remplacement de l'élément identifié par "bash" par le nouvel élément
document.getElementById("langages").replaceChild(zshElt, document.getElementById("bash"));


// Suppression de l'élément identifié par "zsh"
document.getElementById("langages").removeChild(document.getElementById("zsh"));


// Exercice 1 : ajout d'un paragraphe contenant un lien
var pElt = document.createElement("p");
var lienElt = document.createElement("a");
lienElt.href = "https://fr.wikipedia.org/wiki/Liste_des_langages_de_programmation";
lienElt.textContent = "liste";
pElt.appendChild(document.createTextNode("En voici une "));
pElt.appendChild(lienElt);
pElt.appendChild(document.createTextNode(" plus complète."));
document.getElementById("contenu").appendChild(pElt);
