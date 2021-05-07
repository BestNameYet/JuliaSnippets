module File2Hex

function file2hex(filename::AbstractString)
  io -> Array{UInt8, 1}(undef, stat(io).size)
  ans()
  io -> read!(io, ans(io)))
  ans()
  fn -> open(ans, fn))
  ans()
  fn -> bytes2hex(ans(fn)))
  ans()
  return ans
end

end
