
// Ce programme calcule et affiche ensuite la plus grande valeur présente dans le tableau.
var valeurs = [11, 3, 7, 2, 9, 10, 15, 35];

var max = 0;
for (i = 0; i < valeurs.length; i++){
    if (valeurs[i] > max){
        max = valeurs[i]
    }
}

console.log("Le maximum des éléments vaut: " + max)
