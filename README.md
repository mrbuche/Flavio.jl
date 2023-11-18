# Flavio.jl

[![stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://mrbuche.github.io/Flavio.jl/stable)
[![dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://mrbuche.github.io/Flavio.jl/dev)

**flavio welcomes you**

## Installation

Flavio.jl is a Julia wrapper of [flavio](https://github.com/mrbuche/flavio).

```julia
pkg> add Flavio
```

## Example

Calculate the Cauchy stress for an Arruda-Boyce model under an applied deformation gradient:

```julia
julia> using Flavio
julia> model = ArrudaBoyce(13.0, 3.0, 8);
julia> F = [0.63595746 0.69157849 0.71520784;
            0.80589604 0.83687323 0.19312595;
            0.05387420 0.86551549 0.41880244];
julia> cauchy_stress(model, F)
3×3 Matrix{Float64}:
 -19.3743  22.5587    12.3016
  22.5587  -2.44975   19.7963
  12.3016  19.7963   -25.8374
```
