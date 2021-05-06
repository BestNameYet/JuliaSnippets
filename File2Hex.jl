module File2Hex

function arrayfactory end
arrayfactory() = io -> Array{UInt8, 1}(undef, stat(io).size)


function readerfactory end
readerfactory() = (arr = arrayfactory(); io -> read!(io, arr(io)))

function openerfactory end
openerfactory() = (reader = readerfactory(); fn -> open(reader, fn))


function hexerfactory end
hexerfactory() = (opener = openerfactory(); fn -> bytes2hex(opener(fn)))

function file2hex end
file2hex(filename::AbstractString) = (hexer = hexerfactory(); hexer(filename))

end
