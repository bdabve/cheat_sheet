// TODO : écrire la fonction compterElements

function compterElements(elts){
  var Elts = document.querySelectorAll(elts);
  return Elts.length;
}


console.log(compterElements("p")); // Doit afficher 4
console.log(compterElements(".adjectif")); // Doit afficher 3
console.log(compterElements("p .adjectif")); // Doit afficher 3
console.log(compterElements("p > .adjectif")); // Doit afficher 2