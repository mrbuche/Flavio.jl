# Hyperelastic

```@raw html
<style>
    .subsectionTitle {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
</style>
<div class="subsectionTitle">
    <div>
```

* [Arruda-Boyce](hyperelastic/arruda_boyce.md)
* [Fung](hyperelastic/fung.md)
* [Gent](hyperelastic/gent.md)
* [Mooney-Rivlin](hyperelastic/mooney_rivlin.md)
* [Neo-Hookean](hyperelastic/neo_hookean.md)
* [Saint Venant-Kirchoff](hyperelastic/saint_venant_kirchoff.md)

```@raw html
    </div>
    <div>
        <p style="margin:18px;"></p>
        <picture>
            <source srcset="../dark.svg" media="(prefers-color-scheme: dark)"/>
            <img src="../light.svg" alt="Unable to load plot."/>
        </picture>
```

```@setup
using Flavio, Plots
function σ₁₁(model, λ)
    σ₁₁ = zeros(length(λ))
    for (i, λᵢ) in enumerate(λ)
        Fᵢ = [λᵢ 0 0; 0 1/sqrt(λᵢ) 0; 0 0 1/sqrt(λᵢ)]
        σ₁₁[i] = cauchy_stress(model, Fᵢ)[1, 1]
    end
    return σ₁₁
end
p = plot(background_color=:transparent, foreground_color=:white,
         foreground_color_axis=colorant"#5e6d6f",
         foreground_color_border=colorant"#5e6d6f",
         foreground_color_legend=colorant"#5e6d6f",
         grid=false, legendfontsize=8,
         left_margin=10Plots.mm, bottom_margin=5Plots.mm,
         xlabel="λ", xguidefontsize=10, xtickfontsize=10, xlims=(0, 5),
         ylabel="σ/μ", yguidefontsize=10, ytickfontsize=10, ylims=(-10, 20))
λ = 10 .^ range(-1, 0.7, length=100)
plot!(λ, σ₁₁(ArrudaBoyce(1.0, 1.0, 16), λ), linewidth=2, label="Arruda-Boyce")
plot!(λ, σ₁₁(Fung(1.0, 1.0, 1.0, 0.1), λ), linewidth=2, label="Fung")
plot!(λ, σ₁₁(Gent(1.0, 1.0, 30.0), λ), linewidth=2, label="Gent")
plot!(λ, σ₁₁(MooneyRivlin(1.0, 1.0, 0.3), λ), linewidth=2, label="Mooney-Rivlin")
plot!(λ, σ₁₁(NeoHookean(1.0, 1.0), λ), linewidth=2, label="Neo-Hookean")
plot!(λ, σ₁₁(SaintVenantKirchoff(1.0, 1.0), λ), linewidth=2, label="St. Venant-Kirchoff")
savefig(p, "dark.svg")
plot!(background_color=:transparent, foreground_color=:black)
savefig(p, "light.svg")
```

```@raw html
    </div>
</div>
```

## Functions

```@docs
helmholtz_free_energy_density
```
