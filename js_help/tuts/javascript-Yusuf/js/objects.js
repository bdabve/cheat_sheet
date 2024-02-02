/**
 * object
 * - a special variable that can hold multiple values
 *
 * objects consists of properties and values
 * 
 */

// using simple variables
var name = "Yusuf Shakeel";
var id = "s123";

// create an object
var student = {
	name : "Yusuf Shakeel",
	id : "s123"
};

console.log(student);

/**
 * values that we can assign to a property of an object
 *
 * null
 * undefined
 * numbers
 * string
 * object
 * functions
 * array
 */
var sample = {
	prop1 : null,
	prop2 : undefined,
	prop3 : 123,
	prop4 : "Hello World",
	prop5 : {
		a : 1,
		b : "hi"
	},
	prop6 : function () {
		console.log("I am inside a function assigned to prop6");
	},
	prop7 : [1, 2, 3]
};
console.log(sample);

// object for a player
var player = {
	name : "Billy",
	score : 10,
	team : "Team A",

	greetings : function () {
		// console.log("Hello World");
		return "Hello World";
	},

	getScore : function () {
		// var score = 1000;
		return this.score;
	}
};

console.log(player);

// accessing the properties of an object
console.log(player.name);
console.log(player.team);

// calling or invoking a function (method) of an object
console.log(player.greetings());

// adding a new property to an object
// player.match = 3;
player["match"] = 3;

console.log(player);

console.log(player.getScore());

