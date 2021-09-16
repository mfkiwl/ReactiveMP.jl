export Flow, FlowMeta
export getmodel, getapproximation

# specify Flow factor node
struct Flow end
@node Flow Deterministic [ out, in ]

# specify abstract types for Flow building blocks
abstract type AbstractFlowModel end
abstract type AbstractCouplingLayer end
abstract type AbstractCouplingFlow end

# specify abstract types of nonlinear approximation
abstract type AbstractNonLinearApproximation end

@doc raw"""
The `FlowMeta` structure contains the meta data of the `Flow` factor node. More specifically, it contains the model of the `Flow` factor node. The `FlowMeta` structure can be constructed as `FlowMeta(model)`.

The `FlowMeta` structure is required for the `Flow` factor node and can be included with the Flow node as: ```
    y ~ Flow(x) where { meta = FlowMeta(...) }
```
"""
struct FlowMeta{T <: AbstractFlowModel, A <: AbstractNonLinearApproximation}
    model         :: T
    approximation :: A
end
default_meta(::Type{ Flow }) = error("The Flow node requires the meta flag to be explicitly specified. Please create a `FlowMeta` structure for this purpose and include it with the Flow node as: `y ~ Flow(x) where { meta = FlowMeta(...) }` ")

# include approximations
include("approximations/linearization.jl")
include("approximations/unscented.jl")

# structure constructors
function FlowMeta(model::T) where { T <: AbstractFlowModel }
    return FlowMeta(model, Linearization())
end

# get-functions for the FlowMeta structure
getmodel(meta::FlowMeta)         = meta.model
getapproximation(meta::FlowMeta) = meta.approximation

# include neural networks
include("coupling_flows/planar_flow.jl")
include("coupling_flows/radial_flow.jl")

# include layers
include("layers/additive_coupling_layer.jl")
include("layers/reverse_additive_coupling_layer.jl")

# include models
include("flow_models/flow_model.jl")