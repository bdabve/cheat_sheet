

var infoMdp = document.getElementById('infoMdp');
var form = document.querySelector('form');

form.addEventListener("submit", function (e){
    var pwd1 = form.elements.mdp1.value;
    var pwd2 = form.elements.mdp2.value;
    var regex = /\d/;
    if (!regex.test(pwd1)){
        infoMdp.innerHTML = "Erreur: le mot de passe ne contient aucun chiffre";
    } else if((pwd1).length < 6){
        infoMdp.innerHTML = "Erreur: la longueur minimale du mot de passe est de 6 caractères";
    } else if (pwd1 !== pwd2){
        infoMdp.innerHTML = "Erreur: Les mots de pass saisis sont different.";
    }
    e.preventDefault();
});
