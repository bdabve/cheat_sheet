
var films = {
    init: function(titre, annee, realisateur){
        this.titre = titre;
        this.annee = annee;
        this.realisateur = realisateur;
    },

    decrire: function(){
        var description = this.titre + " (" + this.annee + ", " + this.realisateur + ")";
        return description;
    }
}

var film1 = Object.create(films);
film1.init("Le loup de Wall Street", 2013, "Martin Scorsese");
var film2 = Object.create(films);
film2.init("Vice-Versa", 2015, "Pete Docter");
var film3 = Object.create(films);
film3.init("Babysitting", 2013, "Philippe Lacheau et Nicolas Benamou");

var _films = [film1, film2, film3];

_films.forEach( function(film) {
    console.log(film.decrire());
});
