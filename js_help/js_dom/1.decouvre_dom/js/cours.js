/* global document, console*/
var h = document.head; // La variable h contient l'objet head du DOM
console.log(h);

var b = document.body; // La variable b contient l'objet body du DOM
console.log(b);

if (document.body.nodeType === document.ELEMENT_NODE) {
    console.log("Body est un noeud élément");
} else {
    console.log("Body est un noeud textuel");
}

// Accès au premier enfant du noeud body
console.log(document.body.childNodes[0]);

// Accès au deuxième enfant du noeud body
console.log(document.body.childNodes[1]);

// parcouri la list des nodes
for( var i = 0; i < document.body.childNodes.length; ++i){
  console.log('[+] Child Node: ' + i);
  console.log(document.body.childNodes[i]);
}

// Parent node
var h1 = document.body.childNodes[1];
console.log('[+] Parent Node de h1: ');
console.log(h1.parentNode);

console.log('[+] Parent Node de document: ');
console.log(document.parentNode);