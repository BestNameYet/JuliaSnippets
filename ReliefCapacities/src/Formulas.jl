module Formulas

using Unitful

include("moreunits.jl")
include("liquids.jl")
include("gases.jl")


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