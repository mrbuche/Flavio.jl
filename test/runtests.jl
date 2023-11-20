using Aqua, Flavio, JET, JuliaFormatter, LinearAlgebra, Test

ϵ = 1e-6

include("constitutive.jl")

Aqua.test_all(Flavio)

println("\nJET:\n", report_package("Flavio"; toplevel_logger = nothing))

if !format("../", overwrite = false, verbose = true)
    error("File(s) not properly formatted.")
end
