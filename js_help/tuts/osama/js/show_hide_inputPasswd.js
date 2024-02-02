

var myButton = document.getElementById("passwdButton");
var myInput = document.getElementById("passwd");

myButton.onclick = function() {
    'use strickt';

    if (this.textContent === 'Show Password'){
        myInput.setAttribute('type', 'text');
        this.textContent = 'Hide Password';
    } else {
        myInput.setAttribute('type', 'password');
        this.textContent = 'Show Password';
    }
}
