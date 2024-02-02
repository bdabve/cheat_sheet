/**
 * logical operators
 */

// logical AND  &&
// x && y = true if both x and y = true, otherwise = false
/*
var x = false;
var y = false;
console.log(x && y);
*/

// logical OR  ||
// x || y = true if either x = true or y = true
// x || y = false if both x and y = false
/*
var x = false;
var y = false;
console.log(x || y);
*/

// logical NOT  !
// x = true then !x = false
// x = false then !x = true
/*
var x = false;
console.log(!x);
*/


// example 1
/*
var x = 10;
var y = 20;

// (x > y) = false
// (x > -5) = true
// false && true = false
console.log( (x > y) && (x > -5) );	//false
*/

// example 2
/*
var x = 100;
var y = -100;

// (x > y) = true
// (y > 0) = false
// true || false = true
console.log( (x > y) || (y > 0) );
*/


// example 3
var x = 50;
var y = 100;

// (x < y) = true
// !true = false
console.log( !(x < y) );
















