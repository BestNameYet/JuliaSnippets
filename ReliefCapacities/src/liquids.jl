function flowcoeffecientLiquid(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), specificGravity::typeof(1.0), volumetricflowrate::typeof(1.0u"gpm"))::typeof(1.0u"gpm*(1/sqrt(psi))")
    Q = volumetricflowrate;
    SG = specificGravity;
    if(SG ≤ 0.0 || Q ≤ 0.0u"gpm") return 0.0u"gpm*(1/sqrt(psi))" end
    ∆P = inletPressure - outletPressure;
    if(∆P ≤ 0.0u"psi") return (1/0)u"gpm*(1/sqrt(psi))" end
    radicand = SG/∆P; 
    Cv = Q*sqrt(radicand)
    return Cv
end

function flowrateLiquid(;inletPressure::typeof(1.0u"psi"), outletPressure::typeof(1.0u"psi"), specificGravity::typeof(1.0), flowcoeffecient::typeof(1.0u"gpm*(1/sqrt(psi))"))::typeof(1.0u"gpm")
    SG = specificGravity;
    if(SG ≤ 0.0) return (1/0)u"gpm" end
    Cv = flowcoeffecient
    ∆P = inletPressure - outletPressure;
    if(∆P ≤ 0.0u"psi" || Cv ≤ 0.0u"gpm*(1/sqrt(psi))") return 0.0u"gpm" end
    radicand = ∆P/SG;
    Q = Cv*sqrt(radicand)
    return Q;
end