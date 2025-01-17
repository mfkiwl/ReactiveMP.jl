
# [Nodes implementation](@id lib-node)

In the message passing framework, one of the most important concepts is a factor node.
A factor node represents a local function in a factorised representation of a generative model.

!!! note
    To quickly check the list of all available factor nodes that can be used in the model specification language, call `?make_node` or `Base.doc(make_node)`.

## [Adding a custom node](@id lib-custom-node)

`ReactiveMP.jl` exports the `@node` macro that allows for quick definition of a factor node with a __fixed__ number of edges. The interface is the following:

```julia
struct MyNewCustomNode end

@node MyNewCustomNode   Stochastic         [ x, y, z ]
#     ^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^      ^^^^^^^^^^^
#     Node's tag/name   Node's type        A fixed set of edges
#                       Another possible   The very first edge (in this example `x`) is considered
#                       value is           to be the output of the node
#                       `Deterministic`
```

This expression registers a new node that can be used with the inference engine. Note howeve, that the `@node` macro does not generate any message passing update rules.
These must be defined using the `@rule` macro.

## [Node types](@id lib-node-types)

We distinguish different types of factor nodes in order to have better control over Bethe Free Energy computation.
Each factor node has either the [`Deterministic`](@ref) or [`Stochastic`](@ref) functional form type.

```@docs
Deterministic
Stochastic
isdeterministic
isstochastic
sdtype
```

```@setup lib-node-types
using ReactiveMP
```

For example the `+` node has the [`Deterministic`](@ref) type:

```@example lib-node-types
plus_node = make_node(+)

println("Is `+` node deterministic: ", isdeterministic(plus_node))
println("Is `+` node stochastic: ", isstochastic(plus_node))
nothing #hide
```

On the other hand, the `Bernoulli` node has the [`Stochastic`](@ref) type:

```@example lib-node-types
bernoulli_node = make_node(Bernoulli)

println("Is `Bernoulli` node deterministic: ", isdeterministic(bernoulli_node))
println("Is `Bernoulli` node stochastic: ", isstochastic(bernoulli_node))
```

To get an actual instance of the type object we use [`sdtype`](@ref) function:

```@example lib-node-types
println("sdtype() of `+` node is ", sdtype(plus_node))
println("sdtype() of `Bernoulli` node is ", sdtype(bernoulli_node))
nothing #hide
```

## [Node functional dependencies pipeline](@id lib-node-functional-dependencies-pipeline)

The generic implementation of factor nodes in ReactiveMP supports custom functional dependency pipelines. Briefly, the __functional dependencies pipeline__ defines what
dependencies are need to compute a single message. As an example, consider the belief-propagation message update equation for a factor node $f$ with three edges: $x$, $y$ and $z$:

```math
\mu(x) = \int \mu(y) \mu(z) f(x, y, z) \mathrm{d}y \mathrm{d}z
```

Here we see that in the standard setting for the belief-propagation message out of edge $x$, we need only messages from the edges $y$ and $z$. In contrast, consider the variational message update rule equation with mean-field assumption:

```math
\mu(x) = \exp \int q(y) q(z) \log f(x, y, z) \mathrm{d}y \mathrm{d}z
```

We see that in this setting, we do not need messages $\mu(y)$ and $\mu(z)$, but only the marginals $q(y)$ and $q(z)$. The purpose of a __functional dependencies pipeline__ is to determine functional dependencies (a set of messages or marginals) that are needed to compute a single message. By default, `ReactiveMP.jl` uses so-called `DefaultFunctionalDependencies` that correctly implements belief-propagation and variational message passing schemes (including both mean-field and structured factorisations). The full list of built-in pipelines is presented below:

```@docs
DefaultFunctionalDependencies
RequireMessageFunctionalDependencies
RequireMarginalFunctionalDependencies
RequireEverythingFunctionalDependencies
```

## [Node traits](@id lib-node-traits)

Each factor node has to define the [`as_node_functional_form`](@ref) trait function and to specify a [`ValidNodeFunctionalForm`](@ref) singleton as a return object. By default [`as_node_functional_form`](@ref) returns [`UndefinedNodeFunctionalForm`](@ref). Objects that do not specify this property correctly cannot be used in model specification.

!!! note
    [`@node`](@ref) macro does that automatically

```@docs
ValidNodeFunctionalForm
UndefinedNodeFunctionalForm
as_node_functional_form
```
