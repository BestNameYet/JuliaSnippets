module Sandbox

function ismandelbrotian(number; seed = number, attempts = 0)
        if abs(number) > 2; return false
        elseif attempts > 1000; return true; end
        
        attempts += 1
        znext = (number)^2 + seed
        ismandelbrotian(znext, seed = seed, attempts = attempts)
end    

end
