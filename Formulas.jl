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
    if(SG ≤ 0) return (1/0)u"gpm" end
    Cv = flowcoeffecient
    ∆P = inletPressure - outletPressure;
    if(∆P ≤ 0u"psi" || Cv ≤ 0u"gpm*(1/sqrt(psi))") return 0u"gpm" end
    radicand = ∆P/SG;
    Q = Cv*sqrt(radicand)
    return Q;
end

inletP = 100.0u"psi"
outletP = 99.0u"psi"
SG = 1.0
rate = 50.0u"gpm"
const Cv = 50.0u"gpm*(1/sqrt(psi))"

coeffecientTuple = begin
    (
        inletPressure = inletP,
        outletPressure = outletP,
        specificGravity = SG,
        volumetricflowrate = rate
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

@show flowcoeffecientLiquid(;coeffecientTuple...)
@show flowrateLiquid(;flowrateTuple... )


end