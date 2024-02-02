var compteurElt = document.getElementById("compteur");

// Diminue le compteur jusqu'à 0
function diminuerCompteur() {
    // Conversion en nombre du texte du compteur
    var compteur = Number(compteurElt.textContent);
    if (compteur > 1) {
        compteurElt.textContent = compteur -1;
    } else {
        // Annule l'execution repetee
        clearInterval(intervalId);

        // Modifie le titre de la page
        var titre = document.getElementById('titre');
        titre.textContent = "BOUM !!!";

        // Modification du titre au bout de 2 secondes
        setTimeout(function(){
            titre.textContent = "Tout est cassé :(";
        }, 2000);
    }
}

// Appelle la fonction diminuerCompteur toutes les secondes (1000 millisecondes)
var intervalId = setInterval(diminuerCompteur, 1000);


// Deplacement du bloc

var bloc = document.getElementById('bloc');
var cadre = document.getElementById('cadre');
var vitesse = 7;  // Valeur de déplacement en pixels

// Conversion en nombre du diamètre du bloc
var largeurBloc = parseFloat(getComputedStyle(bloc).width);
var animationId = null; // Identifiant de l'animation

// Déplace le bloc sur sa gauche jusqu'au bord du cadre
function deplacerBloc(){
    // Conversion en nombre de la position gauche du bloc
    var xBloc = parseFloat(getComputedStyle(bloc).left);
    // Conversion en nombre de la largeur du cadre
    var xMax = parseFloat(getComputedStyle(cadre).width);
    if (xBloc + largeurBloc <= xMax) { // si le bloc n'est pas encore au bout du cadre
        // Deplacement
        bloc.style.left = (xBloc + vitesse) + "px";
        // Demande au navigateur d'appeler deplacerBloc dés que possible
        animationId = requestAnimationFrame(deplacerBloc);
    } else {
        // Annulation de l'animation
        cancelAnimationFrame(animationId);
    }
}
animationId = requestAnimationFrame(deplacerBloc);    // Début de l'animation


// this examples from lpjm
// Time span
setInterval("showtime(document.getElementById('time'), 1000)") // calling showtime function with id of the element, which is set to execute once a second (every 1.000 milliseconds)

function showtime(object){
    var date = new Date(); // Every time showtime is called, it sets the object date to the current date and time.
    object.innerHTML = date.toLocaleTimeString().substr(0,8)
    /* Set object.innerHTML to the current time in hours, minute, and seconds by a call to toTimeString.
     * This returns a string such as 09:57:17 UTC+0530
     * Truncat to just 8 char with substr
     */
}


SIZE = LEFT = 0;
setInterval(animate, 30)

function animate(){
    SIZE += 10
    LEFT += 3

    if (SIZE == 200) SIZE = 0;
    if (LEFT == 600) SIZE = 0;

    document.getElementById('box').style.width = SIZE + 'px';
    document.getElementById('box').style.height = SIZE + 'px';
    document.getElementById('box').style.left = LEFT + 'px';
}
