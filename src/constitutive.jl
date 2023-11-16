using StaticArrays

macro cauchy_stress

end

struct NeoHookeanModel
    κ
    μ
end

function cauchy_stress(model::NeoHookeanModel, F)
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

function helmholtz_free_energy_density(model::NeoHookeanModel, F)
    return ccall(
        (:neo_hookean_helmholtz_free_energy_density, FLAVIOSO_LIB),
        Float64,
        (Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, F
    )
end