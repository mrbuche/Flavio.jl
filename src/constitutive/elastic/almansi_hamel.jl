using DocStringExtensions

"""
**Parameters**
$(FIELDS)
"""
struct AlmansiHamel
    κ::Real
    μ::Real
end

"""
$(TYPEDSIGNATURES)
"""
function cauchy_stress(model::AlmansiHamel, F)
    raw = ccall(
        (:almansi_hamel_cauchy_stress, FLAVIOSO_LIB),
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
function cauchy_tangent_stiffness(model::AlmansiHamel, F)
    raw = ccall(
        (:almansi_hamel_cauchy_tangent_stiffness, FLAVIOSO_LIB),
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
function first_piola_kirchoff_stress(model::AlmansiHamel, F)
    raw = ccall(
        (:almansi_hamel_first_piola_kirchoff_stress, FLAVIOSO_LIB),
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
function first_piola_kirchoff_tangent_stiffness(model::AlmansiHamel, F)
    raw = ccall(
        (:almansi_hamel_first_piola_kirchoff_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ,
        model.μ,
        F,
    )
    return reshape(unsafe_wrap(Array{Float64}, raw, 81, own = false), (3, 3, 3, 3))
end
