module UTF8

function PrintableASCIItable()
  table = [32:126;]
  utf8table = broadcast(x -> string(x, base=16, pad=2), table)
  asciitable = broadcast(x -> Char(x), table)
  utf8ascii = broadcast((x, y) -> (x, y), utf8table, asciitable)
  return f(key, default) -> get(Dict{AbstractString, AbstractChar}(utf8ascii), key, default)
end

end
