module UTF8

    
 function testhex(key)
    f(x) = string(x, base=16, pad=2)
    g(x) = codepoint(x)
    h(x) = tuple(f(g(x)), x)
    ascii = [1:128;] |> (function(x);Char.(x);end;)|>(function(x);filter(isprint,x);end)
    pairs = h.(ascii)
    dict = Dict(pairs)
    get(dict, key, Char(0))
end 


end
