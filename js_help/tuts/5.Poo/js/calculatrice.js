
function calculer(nb1, operation, nb2){

    if (operation === "+"){
        return nb1 + nb2;
    } else if (operation === "-") {
        return nb1 - nb2;
    } else if (operation === "*") {
        return nb1 * nb2;
    } else if (operation === "/") {
        return nb1 / nb2;
    } else{
        return "Out of range.";
    }
}
console.log(calculer(4, "+", 6)); // Doit afficher 10
console.log(calculer(4, "-", 6)); // Doit afficher -2
console.log(calculer(2, "*", 0)); // Doit afficher 0
console.log(calculer(12, "/", 0)); // Doit afficher Infinity
