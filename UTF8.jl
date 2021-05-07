module UTF8

function hex2print()
  [1:128;]
  broadcast(x -> Char(x), ans)
  printables = filter(isprint, ans)
  broadcast(x -> codepoint(x), ans)
  broadcast(x -> string(x, base=16, pad=2), ans)
  broadcast((u, a)->(u, a), ans, printables)
  Dict(ans)
  return (key) -> get(ans, key, Char(0))
end

end
