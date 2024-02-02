
/**
 * initialize (executed only once)
 * condition (checked every time)
 * body of the loop
 * update (executed after every loop)
 */

/*
// c = 1 and c <= 5 is true
// c = 2 and c <= 5 is true
// c = 3 and c <= 5 is true
// c = 4 and c <= 5 is true
// c = 5 and c <= 5 is true
// c = 6 and c <= 5 is false
for ( var c = 1; c <= 5; c++ ) {

	document.write("<p>" + c + " Hello World</p>");

}
*/

/*
// c = 1 and c <= 5 is true
// c = 2 and c <= 5 is true
// c = 3 and c <= 5 is true
// c = 4 and c <= 5 is true
for ( var c = 1; c <= 5; c++ ) {

	if (c == 4) {
		break;
	}
	else {
		document.write("<p>" + c + " Hello World</p>");
	}

}
*/

// c = 1 and c <= 5 is true
// c = 2 and c <= 5 is true
// c = 3 and c <= 5 is true
// c = 4 and c <= 5 is true (no output)
// c = 5 and c <= 5 is true
// c = 6 and c <= 5 is false
for ( var c = 1; c <= 5; c++ ) {

	if (c == 4) {
		continue;
	}
	else {
		document.write("<p>" + c + " Hello World</p>");
	}

}








