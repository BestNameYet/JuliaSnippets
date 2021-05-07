module UTF8

    
    f = (
    (ascii = [1:128;] |> (y -> Char.(y)) |> (y -> filter(isprint, y)));
    dict = ascii |>
    begin
        k(x) = string(x, base=16, pad=2);
        m(x) = (c = codepoint(x); k(c));
        n(y) = tuple(m(y), y);
        h -> n.(h)
    end |>
    Dict; p(x) = k -> get(x, k, Char(0)); p(dict)
    )


end
