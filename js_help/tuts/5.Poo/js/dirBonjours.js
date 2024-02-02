

function dirBonjour(nom, prenom){
    var msg = "Bonjour, " + nom + " " + prenom + " !";
    return msg;
}

var nom = prompt("Votre nom: ");
var prenom = prompt("Votre prenom: ")

console.log(dirBonjour(nom, prenom))
