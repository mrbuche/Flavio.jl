using LinearAlgebra, Flavio, StaticArrays, Test

κ = 13.0
μ = 3.0

ϵ = 1e-6

Identity = SMatrix{3, 3, Float64}(1, 0, 0, 0, 1, 0, 0, 0, 1)
Zero = zeros(SMatrix{3, 3, Float64})
SimpleShearSmall = SMatrix{3, 3, Float64}(1, 0, 0, ϵ, 1, 0, 0, 0, 1)
VolumetricSmall = Identity * (1 + ϵ)^(1/3)
Deformation = SMatrix{3, 3, Float64}(
    0.63595746, 0.69157849, 0.71520784,
    0.80589604, 0.83687323, 0.19312595,
    0.05387420, 0.86551549, 0.41880244
)

@testset "Neo-Hookean model" begin
    model = NeoHookean(κ, μ)

    @test cauchy_stress(model, Identity) == Zero
    @test abs(cauchy_stress(model, SimpleShearSmall)[4]/ϵ/μ - 1) < ϵ
    @test abs(tr(cauchy_stress(model, VolumetricSmall))/3/ϵ/κ - 1) < ϵ

    @test helmholtz_free_energy_density(model, Identity) == 0.0
    @test helmholtz_free_energy_density(model, Deformation) > 0.0

end
