module UInt8

export getascii

const printables = let
    [1:128;] |>
    (function(x);Char.(x);end;)|>
    (function(x);filter(isprint,x);end)
end

const lookuptable = let g, h, pairs, dict
    g(x) = UInt8(codepoint(x))
    h(x) = tuple(g(x), x)
    pairs = h.(printables)
    Dict(pairs)
end

function getascii(key)
    get(lookuptable, key, UInt8(0x00))
end


end
