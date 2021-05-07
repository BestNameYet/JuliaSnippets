module UTF8

function hex2print()
  table = [1:127;]
  ascii = broadcast(x -> Char(x), table)
  printable_ascii = filter(isprint, ascii)
  printable_utf8_integers = broadcast(x -> codepoint(x), printable_ascii)
  printable_utf8_strings = broadcast(x -> string(x, base=16, pad=2), printable_utf8_integers)
  printable_utf8_ascii = broadcast((utf8, ascii)->(utf8, ascii), printable_utf8_strings, printable_ascii)
  return (key) -> get(Dict{AbstractString, Char}(printable_utf8_ascii), key, Char(0))
end

end
