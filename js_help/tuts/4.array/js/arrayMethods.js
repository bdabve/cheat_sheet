var films = ["Le loup de Wall Street", "Vice-Versa", "Babysitting"];

console.log(films);
console.log("Films Array has: " + films.length + " Elements.");   // Obtenir la taille: Affiche 3
console.log("films[1]: " + films[1]);                     // Affiche "Vice-Versa"
films.push("Les Bronzés");                // Ajouter un élément
films.pop()                             // Remove the last element('Babysitting)
console.log('films after push "Les Bronzés" and pop: ' + films);

// Using the concat methode
fruit = ["Banana", "Grape"]
veg = ["Carrot", "Cabbage"]
console.log("Concat 2 array: " + fruit.concat(veg));     // Concatenates two arrays

console.log("fruit.concat('Orange', 'Poire'): " + fruit.concat("Orange", "Poire"));     // Concatenates two arrays


// Using the join methode
pets = ['Cat', 'Dog', 'Rabbit', 'Hamster']
console.log(pets.join())                // Cat,Dog,Rabbit,Hamster
console.log("pets.join(' '): " + pets.join(' '))             // Cat Dog Rabbit Hamster

// Using the reverse method
sports = ["Football", "Tennis", "Baseball"]
sports.reverse()
console.log("sports.reverse: " + sports)                     // Baseball, Tennis, Football

// Using the sort method
sports = ["Football", "Tennis", "Baseball", "Hockey"]
sports.sort()
document.write(sports + "<br>")
// Reverse alphabetical sort
sports = ["Football", "Tennis", "Baseball", "Hockey"]
sports.sort().reverse()
document.write(sports + "<br>")
// Ascending numeric sort
numbers = [7, 23, 6, 74]
numbers.sort(function(a,b){return a - b})
document.write(numbers + "<br>")
// Descending numeric sort
numbers = [7, 23, 6, 74]
numbers.sort(function(a,b){return b - a})
document.write(numbers + "<br>")