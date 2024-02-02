/* 
Activité 1
*/

// Liste des liens Web à afficher. Un lien est défini par :
// - son titre
// - son URL
// - son auteur (la personne qui l'a publié)
var listeLiens = [
    {
        titre: "So Foot",
        url: "http://sofoot.com",
        auteur: "yann.usaille"
    },
    {
        titre: "Guide d'autodéfense numérique",
        url: "http://guide.boum.org",
        auteur: "paulochon"
    },
    {
        titre: "L'encyclopédie en ligne Wikipedia",
        url: "http://Wikipedia.org",
        auteur: "annie.zette"
    }
];

// TODO : compléter ce fichier pour ajouter les liens à la page web

for (lien of listeLiens){

    //creation de la div qui englobe chacun des trois liens
    var divElt=document.createElement("div");
    divElt.classList.add("lien");
    document.getElementById("contenu").appendChild(divElt);

    //Creation de la balise strong pour qui englobe le titre
    var strongElt=document.createElement("strong");
    divElt.appendChild(strongElt);

    //creation du titre et modification du style pour changer la couleur et enlever le soulignement du href
    var aTitreElt=document.createElement("a");
    aTitreElt.href=lien.url;
    aTitreElt.textContent=lien.titre+" ";
    aTitreElt.style.color="#428bca";
    aTitreElt.style.textDecoration="none";
    strongElt.appendChild(aTitreElt);

    //creation de l'url
    var spanUrlElt=document.createElement("span");
    spanUrlElt.textContent=lien.url;
    divElt.appendChild(spanUrlElt);

    //ajout d'un saut de ligne après l'url
    var brElt=document.createElement("br");
    spanUrlElt.appendChild(brElt);

    //affichage de l'auteur
    var spanAuteurElt=document.createElement("span");
    spanAuteurElt.textContent="Ajouté par "+lien.auteur;
    divElt.appendChild(spanAuteurElt);

    
}