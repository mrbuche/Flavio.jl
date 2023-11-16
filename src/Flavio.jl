module Flavio

const FLAVIOSO = string(dirname(@__FILE__), "/../deps/flavioso/")
const FLAVIOSO_LIB = string(FLAVIOSO, "target/release/libflavioso")

include("constitutive.jl")
include("math.jl")

export inverse_langevin, langevin
export cauchy_stress, helmholtz_free_energy_density
export NeoHookeanModel

end
