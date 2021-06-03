module Formulas
using Unitful
Unitful.register(Main.Formulas)

@unit(GL, "GL", Gallon, (3.785412)*u"l", false);
@unit(gpm, "gpm", GallonPerMinute, 1.0u"GL/minute", false)
@unit(scfh, "scfh", StandardCubicFeetPerHour, 1.0u"ft^3/hr", false)

function flowcoeffecientLiquid(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"gpm"))::typeof(1.0u"gpm*(1/sqrt(psi))")
    Q = volumetricflowrate;
    SG = specificGravity;
    if(SG ≤ 0 || Q ≤ 0u"gpm") return 0u"gpm*(1/sqrt(psi))" end
    ∆P = inletPressure - outletPressure;
    if(∆P ≤ 0u"psi") return (1/0)u"gpm*(1/sqrt(psi))" end
    radicand = SG/∆P; 
    Cv = Q*sqrt(radicand)
    return Cv
end

function flowrateLiquid(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), specificGravity::typeof(1.0), flowcoeffecient::typeof(1.0u"gpm*(1/sqrt(psi))"))::typeof(1.0u"gpm")
    SG = specificGravity;
    if(SG ≤ 0.0) return (1/0)u"gpm" end
    Cv = flowcoeffecient
    ∆P = inletPressure - outletPressure;
    if(∆P ≤ 0.0u"psi" || Cv ≤ 0.0u"gpm*(1/sqrt(psi))") return 0u"gpm" end
    radicand = ∆P/SG;
    Q = Cv*sqrt(radicand)
    return Q;
end

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

inletP = 100.0u"psi"
outletP = 60.0u"psi"
inletT = 100.0u"°F"
SG = 1.0
liquidrate = 50.0u"gpm"
gasrate = 1000.0u"scfh"
Cv = 50.0u"gpm*(1/sqrt(psi))"

coeffecientTuple = begin
    (
        inletPressure = inletP,
        outletPressure = outletP,
        specificGravity = SG,
        volumetricflowrate = liquidrate
    );
end

flowrateTuple = begin
    (
        inletPressure = inletP,
        outletPressure = outletP,
        specificGravity = SG,
        flowcoeffecient = Cv
    );

end

gasflowrateTuple = begin
    (
        inletPressure = inletP,
        outletPressure = outletP,
        specificGravity = SG,
        volumetricflowrate = gasrate,
        inletTemperature = inletT

    );

end

@show flowcoeffecientLiquid(;coeffecientTuple...)
@show flowrateLiquid(;flowrateTuple... )
@show flowcoeffecientGas(;gasflowrateTuple...)

end