using DocStringExtensions

"""
**Parameters**
$(FIELDS)
"""
struct Gent
    κ::Real
    μ::Real
    Jₘ::Real
end

"""
$(TYPEDSIGNATURES)
"""
function cauchy_stress(model::Gent, F)
    raw = ccall(
        (:gent_cauchy_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.Jₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function cauchy_tangent_stiffness(model::Gent, F)
    raw = ccall(
        (:gent_cauchy_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.Jₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function first_piola_kirchoff_stress(model::Gent, F)
    raw = ccall(
        (:gent_first_piola_kirchoff_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.Jₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function first_piola_kirchoff_tangent_stiffness(model::Gent, F)
    raw = ccall(
        (:gent_first_piola_kirchoff_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.Jₘ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function helmholtz_free_energy_density(model::Gent, F)
    return ccall(
        (:gent_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        model.Jₘ,
        F,
    )
end
