function flowcoeffecientGas(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"))::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    P₀ = inletPressure
    P = outletPressure
    if(P₀≥2*P) return criticalflowcoeffecient(;inletPressure, inletTemperature, specificGravity, volumetricflowrate) end
    return subcriticalflowcoeffecient(;inletPressure, outletPressure, inletTemperature, specificGravity, volumetricflowrate)
end

function criticalflowcoeffecient(;inletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"), scalingfactor::typeof(1.0) = 816.0)::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    scalar = scalingfactor
    Q = volumetricflowrate
    T = uconvert(u"Ra",inletTemperature)
    SG = specificGravity
    if(Q ≤ 0.0u"scfh" || SG ≤ 0.0 ||T ≤ 0.0u"Ra")  return 0.0u"sqrt(Ra)*scfh*(1/psi)" end
    P₀ = inletPressure
    if(P₀ ≤ 0.0u"psi") return (1/0)u"sqrt(Ra)*scfh*(1/psi)" end
    radicand = SG*T
    upper = sqrt(radicand)
    lower = scalar*P₀
    Cv = Q*upper/lower
    return Cv
end

function subcriticalflowcoeffecient(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"), scalingfactor::typeof(1.0) = 962.0)::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    scalar = scalingfactor
    Q = volumetricflowrate
    T = uconvert(u"Ra",inletTemperature)
    SG = specificGravity
    if(Q ≤ 0.0u"scfh" || SG ≤ 0.0 ||T ≤ 0.0u"Ra")  return 0.0u"sqrt(Ra)*scfh*(1/psi)" end
    P₀ = inletPressure
    P = outletPressure
    ∆P = P₀ - P
    if(∆P ≤ 0.0u"psi") return (1/0)u"sqrt(Ra)*scfh*(1/psi)" end
    upper = SG*T
    lower = (^(P₀,2)-^(P,2))
    radicand = upper/lower
    Cv = (Q/scalar)*sqrt(radicand)
    return Cv
end