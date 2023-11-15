module Flavio

const FLAVIOSO = string(dirname(@__FILE__), "/../deps/flavioso/")
const FLAVIOSO_LIB = string(FLAVIOSO, "target/release/libflavioso")

include("constitutive.jl")
include("math.jl")

export inverse_langevin, langevin, neo_hookean

end
