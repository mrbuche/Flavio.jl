# Flavio.jl

[![stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://mrbuche.github.io/Flavio.jl/stable)
[![dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://mrbuche.github.io/Flavio.jl/dev)

**flavio welcomes you**

## Installation

Flavio.jl is a Julia wrapper of [flavio](https://github.com/mrbuche/flavio) offering constitutive modeling features.

```julia
pkg> add Flavio
```

## Example

```julia
julia> using Flavio, StaticArrays
julia> model = NeoHookean(13.0, 3.0);
julia> F = SMatrix{3,3,Float64}(
           0.63595746, 0.69157849, 0.71520784,
           0.80589604, 0.83687323, 0.19312595,
           0.05387420, 0.86551549, 0.41880244
       );
julia> cauchy_stress(model, F)
3×3 SMatrix{3, 3, Float64, 9} with indices SOneTo(3)×SOneTo(3):
 -13.249    20.5297   15.5694
  20.5297  -13.3679   14.1711
  15.5694   14.1711  -21.044
```
