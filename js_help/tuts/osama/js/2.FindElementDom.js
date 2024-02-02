/*
        * cours : JavaScript DOM
 
*/
// getElementById
var divElts = document.getElementById('test');
divElts.innerHTML = 'Changed By JavaScript!';

// getElementsByTagName
var pElts = document.getElementsByTagName('p');
console.log('Number of <p>: ' + pElts.length);
pElts[1].innerHTML = "This Paragraph changed by JS";

// getElementsByClassName
var classElts = document.getElementsByClassName("Class");
console.log('Number of class: ' + classElts.length);
console.log(classElts[1]);
