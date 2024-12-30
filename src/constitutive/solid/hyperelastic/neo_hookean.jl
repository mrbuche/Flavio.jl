using DocStringExtensions

"""
**Parameters**
$(FIELDS)
"""
struct NeoHookean
    κ::Real
    μ::Real
end

"""
$(TYPEDSIGNATURES)
"""
function cauchy_stress(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_cauchy_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function cauchy_tangent_stiffness(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_cauchy_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function first_piola_kirchoff_stress(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_first_piola_kirchoff_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function first_piola_kirchoff_tangent_stiffness(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_first_piola_kirchoff_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function second_piola_kirchoff_stress(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_second_piola_kirchoff_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 9, own = false), (3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function second_piola_kirchoff_tangent_stiffness(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_second_piola_kirchoff_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end

"""
$(TYPEDSIGNATURES)
"""
function helmholtz_free_energy_density(model::NeoHookean, F)
    return ccall(
        (:neo_hookean_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
end
