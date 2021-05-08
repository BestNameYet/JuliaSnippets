module File2UInt8

function file2uint8(filename::AbstractString)
    filesize = stat.(filename).size
    filearr = Array{UInt8, 1}(undef, filesize)
    io = open(filename, "r")
    read!(io, filearr)
    close(io)
    return filearr
end

end
