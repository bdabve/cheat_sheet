
var a = {
    prop1: "toto"
};
var b = Object.create(a);
b.prop2 = "titi";
var c = Object.create(b);
c.prop3 = "tutu";

console.log(c.prop1);
console.log(c.prop2);
console.log(c.prop3);

