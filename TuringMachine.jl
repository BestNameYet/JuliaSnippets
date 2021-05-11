module TuringMachine.jl

tape = [0,]
address = 0

function A(tape)
  #(0, A, 1, B)
  if tape[address] == 0
    tape[address] = 1
    address += 1
    return B
  #(1, A, 2, A)
  elseif tape[address] == 1
    tape[address] = 2
    address += 1
    return A
   #(2, A, 1, A)
   elseif tape[address] == 2
    tape[address] = 1
    address += 1
    return A
   end
end

function B(tape)
  #(0, B, 2, A)
  if tape[address] == 0
    tape[address] = 2
    address += 1
    return A
  #(1, B, 2, B)
  elseif tape[address] == 1
    tape[address] = 2
    address += 1
    return B
   #(2, B, 0, A)
   elseif tape[address] == 2
    tape[address] = 0
    address += 1
    return A
   end
end

end
