/**
 * three fruits and three variables
 */
/*
var fruits1 = "Apple";
var fruits2 = "Mango";
var fruits3 = "Orange";
*/

/**
 * three fruits and one array variable
 */
/*
var fruits = ["Apple", "Mango", "Orange"];

console.log(fruits);

console.log("Number of elements: " + fruits.length);

// i = 0 and i < fruits.length is true so, fruits[0] = Apple
// i = 1 and i < fruits.length is true so, fruits[1] = Mango
// i = 2 and i < fruits.length is true so, fruits[2] = Orange
// i = 3 and i < fruits.length is false
for (var i = 0; i < fruits.length; i++) {
	document.write("<p>" + fruits[i] + "</p>");
}
*/

/*
var fruits = new Array();

//add elements to a fruits array we use [] and index of the element
fruits[1] = "Apple";
fruits[3] = "Mango";
fruits[4] = "Orange";

console.log(fruits);
console.log("Number of elements: " + fruits.length);
*/

/**
 * concat()
 */
/*
var arr1 = ['a', 'b'];
var arr2 = ['c'];

var arr3 = arr1.concat(arr2);

console.log(arr1);
console.log(arr2);
console.log(arr3);
*/

/**
 * pop()
 */
/*
var arr1 = ['a', 'b', 'c'];

console.log("initial");
console.log(arr1);

var popelem = arr1.pop();

console.log(popelem);

console.log("final");
console.log(arr1);
*/

/**
 * push()
 */
/*
var arr1 = ['a', 'b', 'c'];

console.log("initial");
console.log(arr1);

arr1.push('d');

console.log("final")
console.log(arr1);
*/

/**
 * indexOf()
 */
var arr1 = ['a', 'b', 'c'];

// console.log("Index Of: " + arr1.indexOf('d'));
// console.log("Index Of: " + arr1.indexOf('b'));

if (arr1.indexOf('c') > -1) {
	console.log("The element is present in the array");
}
else {
	console.log("The element is not present in the array");
}











