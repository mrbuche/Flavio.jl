using StaticArrays

struct ArrudaBoyce
    κ
    μ
    N
end

function cauchy_stress(model::ArrudaBoyce, F)
    raw = ccall(
        (:arruda_boyce_cauchy_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, model.N, F
    )
    return SMatrix{3,3,Float64}(
        unsafe_wrap(Array{Float64}, raw, 9, own=false)
    )
end

function cauchy_tangent_stiffness(model::ArrudaBoyce, F)
    raw = ccall(
        (:arruda_boyce_cauchy_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, model.N, F
    )
    return SArray{Tuple{3,3,3,3},Float64}(
        unsafe_wrap(Array{Float64}, raw, 81, own=false)
    )
end

function helmholtz_free_energy_density(model::ArrudaBoyce, F)
    return ccall(
        (:arruda_boyce_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, model.N, F
    )
end

struct NeoHookean
    κ
    μ
end

function cauchy_stress(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_cauchy_stress, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, F
    )
    return SMatrix{3,3,Float64}(
        unsafe_wrap(Array{Float64}, raw, 9, own=false)
    )
end

function cauchy_tangent_stiffness(model::NeoHookean, F)
    raw = ccall(
        (:neo_hookean_cauchy_tangent_stiffness, FLAVIOSO_LIB),
        Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, F
    )
    return SArray{Tuple{3,3,3,3},Float64}(
        unsafe_wrap(Array{Float64}, raw, 81, own=false)
    )
end

function helmholtz_free_energy_density(model::NeoHookean, F)
    return ccall(
        (:neo_hookean_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, F
    )
end