module Flavio

const FLAVIOSO = string(dirname(@__FILE__), "/../deps/flavioso/")
const FLAVIOSO_LIB = string(FLAVIOSO, "target/release/libflavioso")

include("constitutive.jl")

export cauchy_stress, cauchy_tangent_stiffness
export first_piola_kirchoff_stress, first_piola_kirchoff_tangent_stiffness
export helmholtz_free_energy_density
export AlmansiHamel
export ArrudaBoyce, Fung, Gent, MooneyRivlin, NeoHookean, SaintVenantKirchoff

end
