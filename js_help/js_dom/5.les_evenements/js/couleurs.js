
function couleur(touche) {

    touche = touche.toUpperCase();                 // Pour gérer indifféremment minuscules et majuscules
    var couleur = "";
    switch (touche){
        case "R":
            couleur = "red";
            break ;
        case "J":
            couleur = "yellow";
            break;
        case "B":
            couleur = "blue";
            break;
        case "V":
            couleur = "green";
            break;
        default:
            console.log("Touche: " + touche + " non gérée !");
    }
    return couleur;
}


function changeCouleur(e){
    var touche = String.fromCharCode(e.charCode);            // Récupération de la touche pressée
    var divElts = document.getElementsByTagName("div");
    // divElts.style.backgroundColor = couleur(touche);
    for (var i = 0; i < divElts.length; i++) {
        divElts[i].style.backgroundColor = couleur(touche);
    }
}

document.addEventListener("keypress", changeCouleur);

