module JuliaBasics

#-- Assignment statement
#-- LHS: a name variable is a named location in memory.
#-- RHS: a value (container, function, float, integer, object, string, etc.)

a = 1; println(a)
b = 1.0; println(b)
c = "Hello World!"; println(c)
d = [a, b, c]; println(d)
e1 = (function add1to(this);return 1+this;end); println(e1(a))
e2 = (function (this);return 1+this;end); println(e2(b))
f = (struct MyStuff; this; that; thistoo; end)
g = MyStuff(a, b, c); println(g)
h = g.this; println(h)
k = g.that; println(k)
m = g.thistoo; println(m)
n = true; println(n)
p = false; println(p)

for i in 1:10
  println("for loop: i = $i, i+1 = $(i+1), i*i = $(i*i)")
end
  
for i in 1:10
    for j in 1:10
      println("nested for loop: i = $i, j = $j, i+j = $(i+j), i*j = $(i*j)")
    end
end

dog = ""
i = 1
println("dog = $dog")
dogarray = ["d", "o", "g"]
println(dogarray)
while dog != "dog"
    dog = "$dog*dogarray[i]"
    i += 1
end
println("dog = $dog")


end
