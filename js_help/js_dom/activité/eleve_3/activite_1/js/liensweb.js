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

listeLiens.forEach(function (lien) { // action répétée pour chaque objet du tableau
    
    // création du paragraphe
    var paragrapheElt = document.createElement("p");
    
    // création du titre de lien cliquable
    var titreElt = document.createElement("a"); 
    titreElt.textContent = lien.titre;
    titreElt.href = lien.url;
    
    // ajout de l'affichage de l'adresse du lien
    var lienElt = document.createTextNode(" " + lien.url);
    
    // création de la ballise saut de ligne
    var brElt = document.createElement("br");
    
    // création de l'information sur l'auteur
    var auteurElt = document.createTextNode("Ajouté par " + lien.auteur);
    
    // personnalisation du style 
    
    // style du paragraphe
    paragrapheElt.style.background = "white";
    paragrapheElt.style.padding = "10px";
    
    // style du titre
    titreElt.style.color = "#428bca";
    titreElt.style.textDecoration = "none";
    titreElt.style.fontSize = "1.2em";
    titreElt.style.fontWeight = "bold";
    
    // intégration des éléments dans le paragraphes
    paragrapheElt.appendChild(titreElt);
    paragrapheElt.appendChild(lienElt);
    paragrapheElt.appendChild(brElt);
    paragrapheElt.appendChild(auteurElt);
        
    
    // intégration du paragraphe dans le contenu
    document.getElementById("contenu").appendChild(paragrapheElt);

});