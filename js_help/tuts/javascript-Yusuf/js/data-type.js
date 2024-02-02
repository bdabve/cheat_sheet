var x = 10;
var y = 20;

console.log(x + y);

var str1 = "Hello";
var str2 = "World";

console.log(str1 + " " + str2);

/**
 * data type
 *
 * primitive
 * object (function)
 */

/**
 * primitive data types - can hold one value
 *
 * boolean
 * null
 * undefined
 * number
 * string
 */

//in Java C C++ etc
//int c;

//JavaScript
var c = 10;

console.log(typeof(c));	//number

c = "Hello World";

console.log(typeof(c));	//string


//boolean
var isGameOver = false;	//true and false

//null
var abc = null;

//undefined
var name;

//number
var score = 10;

console.log(typeof score);

//string
var address = "123 street";


//escape sequence - these are special characters starting with \
var s1 = "We\'re learning JavaScript.";	//We're

console.log(s1);


/**
 * object - can hold multiple values
 *
 * key: value pairs
 */

var obj = {};

console.log(typeof obj);	//object

var student = {

	name: "Tom",
	studentid: "A123",
	score: 120.5

};

console.log(student);




