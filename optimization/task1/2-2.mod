# variable definitions and simple bounds
#var x default 4; # the two different blending procedures
#var y default 2;

param eps := 10^(-5);
var counter := 0;
var xk;
var yk;
var xk1 := 4;
var yk1 := 2;
var ak := 1;
var grx;
var gry;
var fk;
var fk1;
param eta := 0.4;

repeat{
let counter := counter + 1;
print("ounet");
let xk:=xk1;
let yk := yk1;
let grx := (xk-yk^2)/(2*((xk-yk^2)^2 +1/100)^(3/4));
let gry := yk - (yk/50 - yk*(xk-yk^2))/((xk-yk^2)^2 +1/100)^(3/4);
let fk := (((xk)-(yk)^2)^2 +1/100)^(1/4) + (yk)^2/100;
#ak-?
let ak := 1;
repeat {
    print("first");
	let ak := ak/2;
	let xk1 := xk - ak * grx;
	let yk1 := yk - ak * gry;
	let fk1 := (((xk1)-(yk1)^2)^2 +1/100)^(1/4) + (yk1)^2/100;	
} until (fk1 <= fk - ak * eta * (grx * grx + gry * gry));
let xk1 := xk - ak * grx;
let yk1 := yk - ak * gry;
#let fk := ((xk-yk^2)^2 +1/100)^(1/4) + yk^2/100;
#let fk1 := ((xk1-yk1^2)^2 +1/100)^(1/4) + yk1^2/100;
} until abs(grx) + abs(gry) < eps;

display xk1, yk1, counter;

