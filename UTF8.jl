module UTF8

function asciidict()
    ascii = [1:128;] |> y -> broadcast(x -> Char(x), y) |> y -> filter(isprint, y)
    dict = ascii |> y -> broadcast(x -> (codepoint(x), x), y) |>
    y -> broadcast(x -> (x).|> (x -> string(x, base=16, pad=2), identity), y) |> Dict
    return k -> get(dict, k, (Char(0)))
end

end
