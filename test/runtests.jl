using LinearAlgebra, Flavio, StaticArrays, Test

κ = 13.0
μ = 3.0
μₑ = SVector(-1.0, 3e-1, -1e-3, 1e-5)
μₘ = 1.0
Jₘ = 23.0
N = 8.0

ϵ = 1e-6

I = SMatrix{3, 3, Float64}(
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
)
Zero = zeros(SMatrix{3, 3, Float64})
SimpleShearSmall = SMatrix{3, 3, Float64}(
    1, ϵ, 0,
    0, 1, 0,
    0, 0, 1
)
VolumetricSmall = I * (1 + ϵ)^(1/3)
F = SMatrix{3, 3, Float64}(
    0.63595746, 0.69157849, 0.71520784,
    0.80589604, 0.83687323, 0.19312595,
    0.05387420, 0.86551549, 0.41880244
)

function test_elastic(model)
    @test cauchy_stress(model, I) == Zero
    @test abs(cauchy_stress(model, SimpleShearSmall)[4]/ϵ/μ - 1) < ϵ
    @test abs(tr(cauchy_stress(model, VolumetricSmall))/3/ϵ/κ - 1) < 3*ϵ
    σ = cauchy_stress(model, F)
    for (i, σᵢ) in enumerate(eachrow(σ))
        for (j, σᵢⱼ) in enumerate(σᵢ)
            @test σᵢⱼ == σ[j, i]
        end
    end
    💩 = cauchy_tangent_stiffness(model, F)
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    @test 💩[l, k, j, i] ≈ 💩[l, k, i, j]
                end
            end
        end
    end
end

function test_hyperelastic(model)
    @test helmholtz_free_energy_density(model, I) == 0.0
    @test helmholtz_free_energy_density(model, F) > 0.0
end

@testset "Almansi-Hamel model" begin
    almansi_hamel_model = AlmansiHamel(κ, μ)
    test_elastic(almansi_hamel_model)
end

@testset "Arruda-Boyce model" begin
    arruda_boyce_model = ArrudaBoyce(κ, μ, N)
    test_elastic(arruda_boyce_model)
    test_hyperelastic(arruda_boyce_model)
end

@testset "Gent model" begin
    gent_model = Gent(κ, μ, Jₘ)
    test_elastic(gent_model)
    test_hyperelastic(gent_model)
end

@testset "Mooney-Rivlin model" begin
    mooney_rivlin_model = MooneyRivlin(κ, μ, μₘ)
    test_elastic(mooney_rivlin_model)
    test_hyperelastic(mooney_rivlin_model)
end

@testset "Neo-Hookean model" begin
    neo_hookean_model = NeoHookean(κ, μ)
    test_elastic(neo_hookean_model)
    test_hyperelastic(neo_hookean_model)
end

@testset "Yeoh model" begin
    yeoh_model = Yeoh(κ, μ, μₑ)
    test_elastic(yeoh_model)
    test_hyperelastic(yeoh_model)
end
