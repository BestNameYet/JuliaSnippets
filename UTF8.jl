module UTF8

function PrintableASCIItable()
  span = 20:1:127
  table = [span]
  utf8table = broadcast(x -> string(x, base=16), table)
  asciitable = broadcast(x -> Char(x), table)
  return f(key, default) -> get(Dict{AbstractString, AbstractString}(table), key, default)
end


function validASCII end
validASCII() = 


end
