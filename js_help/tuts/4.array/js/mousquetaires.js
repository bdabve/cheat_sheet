var mousquetaires = ["Athos", "Porthos", "Aramis"];

// affiche le nom de chaque mousquetaire a laide d'une boucle for.
console.log('Voici les trois mousquetaires: ')
for (var i = 0; i < mousquetaires.length; i++){
    console.log(mousquetaires[i]);
}

// ajoute au tableau le mousquetaire d'Artagnan.
mousquetaires.push("D'Artagnan");

// affiche le nom de chaque mousquetaire a laide d'une boucle forEach.
console.log('A présent, ils sont quatre !')
mousquetaires.forEach( function(mousquetaires) {
    console.log(mousquetaires);
});
