/**
 * adding event handlers
 * - special attributes
 * - inside the script tag
 * - separate js file
 */

var btn = document.getElementById("myBtn");

btn.onclick = function() {
	alert("Button Clicked - Message from js file!");
};