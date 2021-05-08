module UTF8
    
export testhex

const printables = let
    [1:128;] |>
    (function(x);Char.(x);end;)|>
    (function(x);filter(isprint,x);end)
end

const lookuptable = let f, g, h, pairs, dict
    f(x) = string(x, base=16, pad=2)
    g(x) = codepoint(x)
    h(x) = tuple(f(g(x)), x)
    pairs = h.(printables)
    Dict(pairs)
end

function testhex(key)
    get(lookuptable, key, Char(0))
end


end
