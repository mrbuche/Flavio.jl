module Flavio

const FLAVIOSO = string(dirname(@__FILE__), "/../deps/flavioso/")
const FLAVIOSO_LIB = string(FLAVIOSO, "target/release/libflavioso")

include("constitutive.jl")
# no issue when constitutive models have the same name but different types
# (hyperelastic, thermoelastic variants)
# since input arguments will change and take care of everything

export cauchy_stress, cauchy_tangent_stiffness
export helmholtz_free_energy_density
export AlmansiHamel
export ArrudaBoyce, Gent, MooneyRivlin, NeoHookean

end
