// declaration d'objet
// modification

var stylo = {
    type: "bille",
    couleur: "bleu",
    marque: "Bic"
};

console.log("Mon stylo à " + stylo.type + " " + stylo.marque + " écrit en " + stylo.couleur);

stylo.couleur = "rouge";
console.log("Mon stylo à " + stylo.type + " " + stylo.marque + " écrit en " + stylo.couleur);
