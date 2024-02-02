
var Personnage = {
    // Initalise le personnage
    initPerso: function(nom, sante, force){
        this.nom = nom;
        this.sante = sante;
        this.force = force;
    },

    // Attaque un personnage cible
    attaquer: function(cible){
        if (this.sante > 0){
            var degats = this.force;
            console.log(this.nom + " attaque " + cible.nom + " et lui fait " + degats + " Points de dégats.");
            cible.sante = cible.sante - degats;
            if (cible.sante > 0){
                console.log(cible.nom + " a encore " + cible.sante + " points de vie");
            } else {
                cible.sante = 0;
                console.log(cible.nom + " est mort !");
            }
        } else {
            console.log(this.nom + " ne peut pas attaquer: il est mort...");
        }
    }
}

var Joueur = Object.create(Personnage);
// Initialise le joueur
Joueur.initJoueur = function(nom, sante, force){
    this.initPerso(nom, sante, force);
    this.xp = 0;
    this.piece = 10;
    this.cle = 1;
};
//Renvoie la description du joueur
Joueur.decrire = function(){
    var description = this.nom + " a " + this.sante + " Points de vie, " + this.force + " en force et " + this.xp + " Points d'experience, " + this.piece + " pièce d'or et " + this.cle + " clé(s).";
    return description;
};
// Combat un adversaire
Joueur.combattre = function(adversaire){
    this.attaquer(adversaire);
    if (adversaire.sante === 0){
        console.log(this.nom + " a tué " + adversaire.nom + " et gagne " + adversaire.valeur + " points d'experience, ainsi que " + adversaire.piece + " pièces d'or et " + adversaire.cle + " clé(s).");
        this.xp += adversaire.valeur;
        this.piece += adversaire.piece;
        this.cle += adversaire.cle;
    }
};

var Adversaire = Object.create(Personnage);
// Initialise le joueur
Adversaire.initAdversaire = function(nom, sante, force, race, valeur, piece, cle){
    this.initPerso(nom, sante, force);
    this.race = race;
    this.valeur = valeur;
    this.piece = piece;
    this.cle = cle;
};


// Main
var joueur1 = Object.create(Joueur);
joueur1.initJoueur("Aurora", 150, 25);
var joueur2 = Object.create(Joueur);
joueur2.initJoueur("Glacius", 130, 30);

// Affichage de nos joueurs
console.log("Bienvenue dans ce jeu d'aventure ! Voici nos courageux héros :");
console.log(joueur1.decrire());
console.log(joueur2.decrire());

// Notre monstre
var monstre = Object.create(Adversaire);
monstre.initAdversaire("ZogZog", 40, 20, "orc", 10, 10, 1);
console.log("Un affreux monstre arrive: c'est un " + monstre.race + " nomé " + monstre.nom);


monstre.attaquer(joueur1);
monstre.attaquer(joueur2);

joueur1.combattre(monstre);
joueur2.combattre(monstre);

console.log(joueur1.decrire());
console.log(joueur2.decrire());
