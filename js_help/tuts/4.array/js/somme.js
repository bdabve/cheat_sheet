
// Ce programme calcule et affiche ensuite la somme des éléments de ce tableau.
var valeurs = [11, 3, 7, 2, 9, 10, 10];

var somme = 0;
for (i = 0; i < valeurs.length; i++){
    somme = somme + valeurs[i];
}
console.log("La somme des éléments vaut: " + somme);
