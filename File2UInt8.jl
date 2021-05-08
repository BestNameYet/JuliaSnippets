module File2Hex

function file2hex(filename::AbstractString)
    filesize = stat.(filename).size
    filearr = Array{UInt8, 1}(undef, filesize)
    io = open(filename, "r")
    read!(io, filearr)
    close(io)
    return filearr
end

end
