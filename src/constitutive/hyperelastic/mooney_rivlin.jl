struct MooneyRivlin
    κ::Real
    μ::Real
    μₘ::Real
end

function cauchy_stress(model::MooneyRivlin, F)
    raw = ccall(
        (:mooney_rivlin_cauchy_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.μₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

function cauchy_tangent_stiffness(model::MooneyRivlin, F)
    raw = ccall(
        (:mooney_rivlin_cauchy_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.μₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

function first_piola_kirchoff_stress(model::MooneyRivlin, F)
    raw = ccall(
        (:mooney_rivlin_first_piola_kirchoff_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.μₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

function first_piola_kirchoff_tangent_stiffness(model::MooneyRivlin, F)
    raw = ccall(
        (:mooney_rivlin_first_piola_kirchoff_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.μₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

function helmholtz_free_energy_density(model::MooneyRivlin, F)
    return ccall(
        (:mooney_rivlin_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.μₘ,
        F,
    )
end
