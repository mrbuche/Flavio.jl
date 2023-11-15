function neo_hookean(κ::Float64, μ::Float64, F::Matrix{Float64})::Matrix{Float64}
    output = ccall(
        (:neo_hookean, FLAVIOSO_LIB),
        Tuple{Float64,Float64,Float64,
              Float64,Float64,Float64,
              Float64,Float64,Float64},
        (Float64, Float64, 
        Float64, Float64, Float64, 
        Float64, Float64, Float64, 
        Float64, Float64, Float64),
        κ, μ,
        F[1, 1], F[1, 2], F[1, 3],
        F[2, 1], F[2, 2], F[2, 3],
        F[3, 1], F[3, 2], F[3, 3]
    )
    return [output[1] output[2] output[3];
            output[4] output[5] output[6];
            output[7] output[8] output[9]]
end