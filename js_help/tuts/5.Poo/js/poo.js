
var Personnage = {
    nom: "",
    sante: 0,
    force: 0,
    xp: 0,

    // Renvoie la description du personnage
    decrire: function (){
        var description = "Nom: " + this.nom + "\nPoints de vie: " + this.sante + "\nForce: " + this.force + "\nXp: " + this.xp;
        return description
    }
};

var perso1 = Object.create(Personnage);
perso1.nom = "Aurora";
perso1.sante = 150;
perso1.force = 25;

var perso2 = Object.create(Personnage);
perso2.nom = "Glacius";
perso2.sante = 130;
perso2.force = 35;


console.log(perso1.decrire())
console.log(perso2.decrire())


// initialisation des personnages

var Personnage = {
    // Initalise le personnage
    init: function(nom, sante, force){
        this.nom = nom;
        this.sante = sante;
        this.force = force;
        this.xp = 0;
    },

    // Renvoie la description du personnage
    decrire: function(){
        var description = "Nom: " + this.nom + "\nPoints de vie: " + this.sante + "\nForce: " + this.force + "\nXp: " + this.xp;
        return description
    }
};

var perso1 = Object.create(Personnage);
perso1.init("AEK", 100, 15);

var perso2 = new Object(Personnage);
perso2.init("Meziane", 90, 65);

console.log(perso1.decrire())
console.log(perso2.decrire())
