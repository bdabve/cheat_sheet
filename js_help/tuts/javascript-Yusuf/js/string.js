/**
 * string
 *
 * "Apple"
 * 'Orange'
 */

/*
var str = "Hello World";

console.log(typeof str);	//string

var str2 = new String("Hello World");

console.log(typeof str2);	//object

console.log("str: " + str);
console.log("str2: " + str2);
*/

/*
var str1 = "Apple";
var str2 = "Apple";

console.log("Equal to: " + (str1 == str2));	//true
console.log("Equal and same type: " + (str1 === str2));	//true
*/

/*
var str1 = new String("Apple");
var str2 = new String("Apple");

console.log("Equal to: " + (str1 == str2));	//false
console.log("Equal and same type: " + (str1 === str2));	//false
*/

/*
var str = "abc";

console.log("Number of characters: " + str.length);

// i = 0 and i < str.length is true so, str[0] = a
// i = 1 and i < str.length is true so, str[1] = b
// i = 2 and i < str.length is true so, str[2] = c
// i = 3 and i < str.length is false
for (var i = 0; i < str.length; i++) {
	console.log(str[i]);
}
*/

/**
 * charAt()
 */
/*
var str = "abc";

console.log(str.charAt(100));
*/

/**
 * concat()
 */
/*
var str1 = "Hello";
var str2 = "World";

var str3 = str1.concat(" ", str2);

console.log(str1);
console.log(str2);
console.log(str3);
*/

/**
 * indexOf()
 */
/*
var str = "abc";

if (str.indexOf('d') > -1) {
	console.log("The character is present in the string");
}
else {
	console.log("The character is not present in the string");
}
*/

var str = "Hello World";

var s = "Hi";

var index = str.indexOf(s);

console.log(index);

if (index > -1) {
	console.log("The string is present");
}
else {
	console.log("The string is not present");
}
















