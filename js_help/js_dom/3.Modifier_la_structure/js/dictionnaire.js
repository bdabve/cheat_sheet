// Liste des mots du dictionnaire
var mots = [
    {
        terme: "Procrastination",
        definition: "Tendance pathologique à remettre systématiquement au lendemain"
    },
    {
        terme: "Tautologie",
        definition: "Phrase dont la formulation ne peut être que vraie"
    },
    {
        terme: "Oxymore",
        definition: "Figure de style qui réunit dans un même syntagme deux termes sémantiquement opposés"
    }
];

// TODO : créer le dictionnaire sur la page web, dans la div "contenu"

var dlElt = document.createElement('dl');

for (var mot of mots){  
  var dtElt = document.createElement('dt');
  var strongElt = document.createElement('strong');
  strongElt.textContent = mot.terme;
  
  var ddElt = document.createElement('dd');
  ddElt.textContent = mot.definition;
  
  dtElt.appendChild(strongElt);  
  dlElt.appendChild(dtElt);
  dlElt.appendChild(ddElt);  
}

document.getElementById('contenu').appendChild(dlElt);


// Openclassrooms solution

var contenu = document.getElementById('contenu');
var h2Elt = document.createElement('h2');
h2Elt.textContent = 'OC Solution';

var dlElt = document.createElement("dl"); // Création de la liste

// Pour chaque mot, on construit une balise <dt> avec le terme et une balise <dd> avec sa définition
mots.forEach(function (mot) {
    var dtElt = document.createElement("dt");
    var strongElt = document.createElement("strong");
    strongElt.textContent = mot.terme;
    var ddElt = document.createElement("dd");
    ddElt.textContent = mot.definition;

    dtElt.appendChild(strongElt);
    dlElt.appendChild(dtElt);
    dlElt.appendChild(ddElt);
});

contenu.appendChild(h2Elt);
contenu.appendChild(dlElt); // Ajout de la liste à la page