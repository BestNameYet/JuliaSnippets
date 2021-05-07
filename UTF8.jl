module UTF8

function PrintableASCIItable()
  table = [32:126;]
  utf8table = broadcast(x -> string(x, base=16, pad=2), table)
  asciitable = broadcast(x -> Char(x), table)
  utf8ascii = broadcast((x, y) -> (x, y), utf8table, asciitable)
  return (key) -> get(Dict{AbstractString, Char}(utf8ascii), key, Char(0))
end

end
