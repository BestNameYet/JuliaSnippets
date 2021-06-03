function flowcoeffecientGas(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"))::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    P0 = inletPressure
    P1 = outletPressure
    if(P0≥2*P1) return criticalflowcoeffecient(;inletPressure, inletTemperature, specificGravity, volumetricflowrate) end
    return subcriticalflowcoeffecient(;inletPressure, outletPressure, inletTemperature, specificGravity, volumetricflowrate)
end

function criticalflowcoeffecient(;inletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"), scalingfactor::typeof(1.0) = 816.0)::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    scalar = scalingfactor
    Q = volumetricflowrate
    T0 = uconvert(u"Ra",inletTemperature)
    SG = specificGravity
    if(Q ≤ 0.0u"scfh" || SG ≤ 0.0 ||T0 ≤ 0.0u"Ra")  return 0.0u"sqrt(Ra)*scfh*(1/psi)" end
    P0 = inletPressure
    if(P0 ≤ 0.0u"psi") return (1/0)u"sqrt(Ra)*scfh*(1/psi)" end
    radicand = SG*T0
    upper = sqrt(radicand)
    lower = scalar*P0
    @show Cv = Q*upper/lower
    return Cv
end

function subcriticalflowcoeffecient(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), inletTemperature::typeof(1.0u"°F"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"scfh"), scalingfactor::typeof(1.0) = 962.0)::typeof(1.0u"sqrt(Ra)*scfh*(1/psi)")
    scalar = scalingfactor
    Q = volumetricflowrate
    T0 = uconvert(u"Ra",inletTemperature)
    SG = specificGravity
    if(Q ≤ 0.0u"scfh" || SG ≤ 0.0 ||T0 ≤ 0.0u"Ra")  return 0.0u"sqrt(Ra)*scfh*(1/psi)" end
    P0 = inletPressure
    P1 = outletPressure
    ∆P = P0 - P1
    if(∆P ≤ 0.0u"psi") return (1/0)u"sqrt(Ra)*scfh*(1/psi)" end
    upper = SG*T0
    lower = (^(P0,2)-^(P1,2))
    radicand = upper/lower
    @show Cv = (Q/scalar)*sqrt(radicand)
    return Cv
end