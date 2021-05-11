module TuringMachine.jl

function A(tapevalue)
  #(0, A, 1, right, B)
  if tapevalue == 0
  return (1, moveright, B)
  #(1, A, 2, left, A)
  elseif tapevalue == 1
  return (2, moveleft, A)
   #(2, A, 1, left, A)
   elseif tapevalue == 2
   return (1, moveleft, A)
   end
end

function B(tapevalue)
   #(0, B, 2, left, A)
  if tapevalue == 0
  return (2, moveleft, A)
  #(1, B, 2, right, B)
  elseif tapevalue == 1
   return (2, moveright, B)
   #(2, B, 0, right, A)
   elseif tapevalue == 2
    return (0, moveright, A)
    end
end

moveleft(address) = address - 1
moveright(address) = address + 1

function runmachine(;state, tape, address)
    while address < 1 || address > length(tape)
        sym, move, st = state(tape[address])
        move(address)
    end
        
end





end
