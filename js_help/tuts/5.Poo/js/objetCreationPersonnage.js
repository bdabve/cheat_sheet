var perso = {
    nom: "Aurora",
    sante: 150,
    force: 25,
    xp: 0,

    // Renvoie la description du personnage
    decrire: function(){
        var description = this.nom + " a " + this.sante + " points de vie et " + this.force + " en force et " + this.xp + " points d'experience.";
        return description;
    }
};

console.log(perso.decrire());
perso.sante = perso.sante - 20;
perso.force = perso.force + 10;
perso.xp = perso.xp + 15;

console.log(perso.decrire());


// Modélisation d'un chien
var chien = {
    nom: "Crockdur",
    race: "Berger",
    taille: 70,

    decrire: function(){
        var description = this.nom + " est un " + this.race + " mesurant " + this.taille + " cm";
        return description
    }
}

console.log(chien.decrire())
