module TuringMachine.jl

using Random
tape = rand(0:1,150)
address = 1

function A(tape)
    if address < 1 || address > length(tape)
        return "halt"
    end
    
  #(0, A, 1, B)
  if tape[address] == 0
    tape[address] = 1
    global address += 1
    return B
  #(1, A, 2, A)
  elseif tape[address] == 1
    tape[address] = 2
    global address += 1
    return A
   #(2, A, 1, A)
   elseif tape[address] == 2
    tape[address] = 1
    global address += 1
    return A
   end
end

function B(tape)
    if address < 1 || address > length(tape)
        return "halt"
    end
  #(0, B, 2, A)
  if tape[address] == 0
    tape[address] = 2
    global address += 1
    return A
  #(1, B, 2, B)
  elseif tape[address] == 1
    tape[address] = 2
    global address += 1
    return B
   #(2, B, 0, A)
   elseif tape[address] == 2
    tape[address] = 0
    global address += 1
    return A
   end
end

x = A
println("I: $tape")

while x != "halt"
    global x = x(tape)
end

println("H: $tape")

end
