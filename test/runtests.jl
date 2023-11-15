using Flavio, Test

@testset "Neo-Hookean" begin
    κ = 13.0
    μ = 13.0
    F = [1.0 0.0 0.0;
         0.0 1.0 0.0;
         0.0 0.0 1.0]
    σ = Flavio.neo_hookean(κ, μ, F)
    for σ_i in σ
        for σ_ij in σ_i
            @test σ_ij == 0.0
        end
    end
end
