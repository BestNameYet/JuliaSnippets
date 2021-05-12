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

function scanfortoken(index, bits)
  maybeascii = bits[index, index+Int(bits[index])]
  return isascii(maybestring) ? String(maybeascii) : nothing
end




end
