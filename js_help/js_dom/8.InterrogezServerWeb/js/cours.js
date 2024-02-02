// Creation d'une requete HTTP
var req = new XMLHttpRequest();

// Requete HTTP GET synchrone vers le fichier langages.txt publié localement
req.open("GET", "http://localhost/js-web-srv/data/langages.txt", false);

// Envoi de la requete
req.send(null);

// Affiche la reponse recue pour la requete
console.log(req.responseText);
