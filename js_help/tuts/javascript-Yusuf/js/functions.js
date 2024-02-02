/**
 * Function
 * - a function is a block of code that is executed when we call the
 * function
 */

//creating a function
function greetings() {
	console.log("Hello World");
}

//calling the greetings function
greetings();

/**
 * Naming functions
 *
 * letters a-z A-Z
 * digits 0-9
 * dollar $
 * underscore _
 *
 * note! function name must not start with a digit
 */

/**
 * function declaration
 * - this is creation of a function
 */
function foo() {
	console.log("We are inside the foo function.");
}

/**
 * function expression
 * - this is a function without any name and it is assigned to a
 * variable
 */
var fun = function () {
	console.log("inside a function that is assigned to variable fun.");
};

/**
 * invoking functions
 * - this is calling a function
 */
foo();

fun();

/**
 * function parameters
 * - these are placeholders for the values that we pass to a function
 */
function add(x, y) {
	var sum = x + y;
	console.log("Sum: " + sum);
}

add(1, 2);
add(100, 200);

/**
 * returning values from a function
 * - we use the return keyword to return a value from a function
 *
 * by default function will return undefined
 */
function subtract(x, y) {
	var diff = x - y;
	// console.log("Diff: " + diff);
	return diff;
}

var result = subtract(10, 5);
console.log(result);

var result2 = subtract(100, 60);
console.log(result2);




