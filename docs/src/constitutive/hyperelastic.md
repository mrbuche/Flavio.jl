# Hyperelastic

* [Arruda-Boyce](hyperelastic/arruda_boyce.md)
* [Gent](hyperelastic/gent.md)
* [Fung](hyperelastic/fung.md)
* [Mooney-Rivlin](hyperelastic/mooney_rivlin.md)
* [Neo-Hookean](hyperelastic/neo_hookean.md)
* [Saint Venant-Kirchoff](hyperelastic/saint_venant_kirchoff.md)

```@example
using Flavio, LaTeXStrings, Plots # hide
function σ₁₁(model, λ) # hide
    σ₁₁ = zeros(length(λ)) # hide
    for (i, λᵢ) in enumerate(λ) # hide
        Fᵢ = [λᵢ 0 0; 0 1/sqrt(λᵢ) 0; 0 0 1/sqrt(λᵢ)] # hide
        σ₁₁[i] = cauchy_stress(model, Fᵢ)[1, 1] # hide
    end # hide
    return σ₁₁ # hide
end # hide
λ = 10 .^ range(-1, 0.7, length=100) # hide
plot() # hide
plot!(λ, σ₁₁(ArrudaBoyce(1.0, 1.0, 16), λ), label="Arruda-Boyce") # hide
plot!(λ, σ₁₁(Fung(1.0, 1.0, 1.0, 0.1), λ), label="Fung") # hide
plot!(λ, σ₁₁(Gent(1.0, 1.0, 30.0), λ), label="Gent") # hide
plot!(λ, σ₁₁(MooneyRivlin(1.0, 1.0, 0.3), λ), label="Mooney-Rivlin") # hide
plot!(λ, σ₁₁(NeoHookean(1.0, 1.0), λ), label="Neo-Hookean") # hide
plot!(λ, σ₁₁(SaintVenantKirchoff(1.0, 1.0), λ), label="St. Venant-Kirchoff") # hide
xlabel!(L"λ") # hide
ylabel!(L"σ/μ") # hide
xlims!(0, 5) # hide
ylims!(-10, 20) # hide
```

## Functions

```@docs
helmholtz_free_energy_density
```
