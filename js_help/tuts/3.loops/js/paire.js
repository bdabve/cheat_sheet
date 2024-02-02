
var nombre = Number(prompt("Entre votre nombre: "))

for (var i = 1; i <= nombre; i++) {
    if (i % 2 === 0) {
        console.log(i + " est pair");
    } else {
        console.log(i + " est impaire")
    }
}
