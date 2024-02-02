function insert(num){
    document.form.textview.value = document.form.textview.value+num;
}

function equal(){
    var exp = document.form.textview.value;
    if(exp){
        document.form.textview.value = eval(document.form.textview.value);
    }
}

function clean(){
    document.form.textview.value = "";
}

function back(){
    var exp = document.form.textview.value;
    document.form.textview.value = exp.substring(0, exp.length-1);
}

document.addEventListener("keypress", function(e) {
    value = String.fromCharCode(e.charCode);
    if (value == "=") {
        equal()
    } else {
        document.form.textview.value += value;
    }
})
