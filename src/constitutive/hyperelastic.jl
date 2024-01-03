using DocStringExtensions

include("hyperelastic/almansi_hamel.jl")
include("hyperelastic/arruda_boyce.jl")
include("hyperelastic/gent.jl")
include("hyperelastic/mooney_rivlin.jl")
include("hyperelastic/neo_hookean.jl")

abstract type Hyperelastic end

"""
$(TYPEDSIGNATURES)
```math
a = a(\\mathbf{F})
```
"""
function helmholtz_free_energy_density(model::Hyperelastic, F) end

"""
$(TYPEDSIGNATURES)
```math
\\boldsymbol{\\sigma}(\\mathbf{F}) = \\frac{1}{J}\\frac{\\partial a}{\\partial\\mathbf{F}}\\cdot\\mathbf{F}^T
```
"""
function cauchy_stress(model::Hyperelastic, F) end

"""
$(TYPEDSIGNATURES)
```math
\\boldsymbol{\\mathcal{T}}(\\mathbf{F}) = \\frac{\\partial\\boldsymbol{\\sigma}}{\\partial\\mathbf{F}}
```
"""
function cauchy_tangent_stiffness(model::Hyperelastic, F) end
