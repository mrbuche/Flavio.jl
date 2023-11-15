using StaticArrays

struct NeoHookeanModel
    κ::Float64
    μ::Float64
end

function cauchy_stress(model::NeoHookeanModel, F::SMatrix{3,3,Float64})::SMatrix{3,3,Float64}
    output = ccall(
        (:neo_hookean_cauchy_stress, FLAVIOSO_LIB), Ptr{Float64},
        (Float64, Float64, Ptr{Float64}),
        model.κ, model.μ, F
    )
    return SMatrix{3,3,Float64}(
        unsafe_wrap(Array{Float64}, output, 9, own=false)
    )
end