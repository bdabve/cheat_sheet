var jour = prompt("Entrez un jour de la semaine :")


switch (jour) {
    case "samedi":
        console.log("Demain, nous seront Dimanche")
        break;
    case "dimanche":
        console.log("Demain, nous seront Lundi")
        break;
    case "lundi":
        console.log("Demain, nous seront Mardi")
        break;
    case "mardi":
        console.log("Demain, nous seront Mercredi")
        break;
    case "mercredi":
        console.log("Demain, nous seront Jeudi")
        break;
    case "jeudi":
        console.log("Demain, nous seront Vendredi")
        break;
    case "vendredi":
        console.log("Demain, nous seront Samedi")
        break;
    default:
        console.log("Je n'ai pas compris !");
        break;
}
