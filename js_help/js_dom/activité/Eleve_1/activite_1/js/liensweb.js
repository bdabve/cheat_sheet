/*
Activité 1
*/

// Liste des liens Web à afficher. Un lien est défini par :
// - son titre
// - son URL
// - son auteur (la personne qui l'a publié)
var listeLiens = [
    {
        titre: "So Foot ",
        url: "http://sofoot.com",
        auteur: "yann.usaille"
    },
    {
        titre: "Guide d'autodéfense numérique ",
        url: "http://guide.boum.org",
        auteur: "paulochon"
    },
    {
        titre: "L'encyclopédie en ligne Wikipedia ",
        url: "http://Wikipedia.org",
        auteur: "annie.zette"
    }
];

var contenu = document.getElementById('contenu');


for (var i = 0; i < listeLiens.length; i++) {

	var divElt = document.createElement('div');

	var titreElt = document.createElement('a');

	var lienElt = document.createElement('span');

	var auteurElt = document.createElement('p');

	titreElt.innerHTML = listeLiens[i].titre;
	titreElt.style.color = '#428bca';
	titreElt.href = lienElt.innerHTML;
	titreElt.style.textDecoration = "none";
	lienElt.innerHTML = listeLiens[i].url;

	auteurElt.innerHTML = listeLiens[i].auteur;

	divElt.appendChild(titreElt);
	divElt.appendChild(lienElt);
	divElt.appendChild(auteurElt);
	divElt.className = "lien";

	contenu.appendChild(divElt);

}
