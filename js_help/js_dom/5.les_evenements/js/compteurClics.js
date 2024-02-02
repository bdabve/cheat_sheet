
function clic(){
    compteurClics ++;
    document.getElementById("compteurClics").textContent = compteurClics;
}

var clicElts = document.getElementById("clic");
var compteurClics = 0;
clicElts.addEventListener("click", clic);

document.getElementById("desactiver").addEventListener("click", function desactiver(){
    clicElts.removeEventListener("click", clic);
})
