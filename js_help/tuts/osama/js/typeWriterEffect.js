
var myText = "Hello, From dabve. This is a text Message Trying type writer :). ";
var myButton = document.getElementById('button')

i = 0
myButton.onclick = function (){
    'use strict';

    var typeWriter = setInterval( function (){              // set interval of 100ms
        document.getElementById('type').textContent += myText[i];   // adding text to <p> elements
        i = i + 1;
        if (i > myText.length -1){
            clearInterval(typeWriter);      // clearing interval.
        }
    }, 100);
};
