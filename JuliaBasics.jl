module JuliaBasics

#-- Assignment statement
#-- LHS: a name variable is a named location in memory.
#-- RHS: a value (container, function, float, integer, object, string, etc.)

a = 1;
b = 1.0;
c = "Hello World!"
d = [a, b, c]
e = (add1to(me) = me + 1)
f = (struct MyStuff; this; that; thistoo; end)(a, b, c)
println("$f.this, $f.that, $f.thistoo");



end
