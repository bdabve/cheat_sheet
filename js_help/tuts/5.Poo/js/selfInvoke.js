/* global document */

function converDollarDz() {
  "use strict";
  
  var amount = document.getElementById("dollar").value,
      result = amount * 118.31;
  var message = document.getElementById("result");
  
  if (amount === ""){
    message.innerHTML = "This field can't be empty";
  } else if (isNaN(amount)) {
    message.innerHTML = "This field accept NUMBERS only";
  } else if (amount <= "0") {
    message.innerHTML = "The Value must not be negative or equal to zero.";
  } else {
    message.innerHTML = amount + " Dollar = " + result + " DA";
  }
}