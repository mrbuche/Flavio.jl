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
    σ(F) = cauchy_stress(model, F)
    P(F) = first_piola_kirchoff_stress(model, F)
    @test σ(I) == Zero
    @test abs(σ(SimpleShearSmall)[4]/ϵ - μ) < ϵ
    @test abs(tr(σ(VolumetricSmall))/3/ϵ/κ - 1) < 3*ϵ
    @test σ(F) == transpose(σ(F))
    @test σ(F) ≈ (transpose(F)*P(F))/det(F)
    @test P(I) == Zero
    T = cauchy_tangent_stiffness(model, F)
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    @test T[l, k, j, i] ≈ T[l, k, i, j]
                    Fd = MMatrix(copy(F))
                    Fd[l, k] += ϵ/2
                    dσᵢⱼ = σ(Fd)[i, j]
                    Fd[l, k] -= ϵ
                    dσᵢⱼ -= σ(Fd)[i, j]
                    @test abs(T[l, k, j, i] - dσᵢⱼ/ϵ) < ϵ
                end
            end
        end
    end
    C = first_piola_kirchoff_tangent_stiffness(model, F)
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    Fd = MMatrix(copy(F))
                    Fd[l, k] += ϵ/2
                    dPᵢⱼ = P(Fd)[j, i]
                    Fd[l, k] -= ϵ
                    dPᵢⱼ -= P(Fd)[j, i]
                    @test abs(C[l, k, j, i] - dPᵢⱼ/ϵ) < ϵ
                end
            end
        end
    end
end

function test_hyperelastic(model)
    a(F) = helmholtz_free_energy_density(model, F)
    P(F) = first_piola_kirchoff_stress(model, F)
    @test a(I) == 0.0
    for (i, Pᵢ) in enumerate(eachrow(P(I)))
        for (j, Pᵢⱼ) in enumerate(Pᵢ)
            Fd = MMatrix(copy(I))
            Fd[i, j] += ϵ/2
            da = a(Fd)
            Fd[i, j] -= ϵ
            da -= a(Fd)
            @test abs(Pᵢⱼ - da/ϵ) < ϵ
        end
    end
    @test a(F) > 0.0
    for (i, Pᵢ) in enumerate(eachrow(P(F)))
        for (j, Pᵢⱼ) in enumerate(Pᵢ)
            Fd = MMatrix(copy(F))
            Fd[i, j] += ϵ/2
            da = a(Fd)
            Fd[i, j] -= ϵ
            da -= a(Fd)
            @test abs(Pᵢⱼ - da/ϵ) < ϵ
        end
    end
    C = first_piola_kirchoff_tangent_stiffness(model, F)
    for i = 1:3
        for j = 1:3
            for k = 1:3
                for l = 1:3
                    @test C[l, k, j, i] ≈ C[j, i, l, k]
                end
            end
        end
    end
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
