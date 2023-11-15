module Flavio

const FLAVIOSO = string(dirname(@__FILE__), "/../deps/flavioso/")
const FLAVIOSO_LIB = string(FLAVIOSO, "target/release/libflavioso")

include("constitutive.jl")
include("math.jl")

export inverse_langevin, langevin, cauchy_stress, NeoHookeanModel

end
