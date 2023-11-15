using LinearAlgebra, Flavio, StaticArrays, Test

κ = 13.0
μ = 3.0

ϵ = 1e-6

Identity = SMatrix{3, 3, Float64}(1, 0, 0, 0, 1, 0, 0, 0, 1)
Zero = zeros(SMatrix{3, 3, Float64})
SimpleShearSmall = SMatrix{3, 3, Float64}(1, 0, 0, ϵ, 1, 0, 0, 0, 1)
VolumetricSmall = Identity * (1 + ϵ)^(1/3)

@testset "Neo-Hookean model" begin
    model = NeoHookeanModel(κ, μ)
    @test cauchy_stress(model, Identity) == Zero
    @test abs(cauchy_stress(model, SimpleShearSmall)[4]/ϵ/μ - 1) < ϵ
    @test abs(tr(cauchy_stress(model, VolumetricSmall))/3/ϵ/κ - 1) < ϵ
end
