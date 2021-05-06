module File2Hex

function arrayfactory()
  return io -> Array{UInt8, 1}(undef, stat(io).size)
end

function readerfactory()
  arr = arrayfactory()
  return io -> read!(io, arr(io))
end

function openerfactory()
  reader = readerfactory()
  return fn -> open(reader, fn)
end

function hexerfactory()
  opener = openerfactory()
  return fn -> bytes2hex(opener(fn))
end

function file2hex(filename::AbstractString)
    hexer = hexerfactory()
    return hexer(filename)
end

end
