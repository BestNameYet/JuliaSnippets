module Parser

function findtoken(bits::Array{Uint8})
  tokens::String = []
  for (i, bit) in enumerate(bits)
    if Int(bit) < 32
      token = scanfortoken(i, bits)
      !isnothing(token) && continue
      tokens.push!(token)
    end
  end
end

function findstring(bits::Array{Uint8})
  tokens::String = []
  for (i, bit) in enumerate(bits)
    if isascii(bit)
      token = scanfortoken(i, bits)
      !isnothing(token) && continue
      tokens.push!(token)
    end
  end
end

function scanfortoken(index::Int, bits::AbstractArray)
  maybeascii = bits[index, index+Int(bits[index])]
  return isascii(maybestring) ? String(maybeascii) : nothing
end

function scanfortoken(index::Int, bits::AbstractArray)
  while Char(i)
  maybeascii = bits[index, index+Int(bits[index])]
  return isascii(maybestring) ? String(maybeascii) : nothing
end



end
