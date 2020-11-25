export AbstractVariable, degree
export RandomVariable, randomvar
export SimpleRandomVariable, simplerandomvar
export ConstVariable, constvar
export DataVariable, datavar, update!, finish!
export getmarginal, getmarginals, setmarginal!, activate!, name
export as_message, as_marginal
export as_variable

using Rocket

abstract type AbstractVariable end

function degree end

## Common functions

getmarginals(vector::AbstractVector{ <: AbstractVariable }) = map(getmarginal, vector)

function getmarginal(variable::AbstractVariable)
    vmarginal = _getmarginal(variable)
    if vmarginal === nothing
        nmarginal = as_marginal_observable(_makemarginal(variable))
        _setmarginal!(variable, nmarginal)
        return nmarginal
    end
    return as_marginal_observable(vmarginal)
end

function setmarginal!(variable::AbstractVariable, marginal)
    setmarginal!(getmarginal(variable), marginal)
end

function name(variable::AbstractVariable)
    return variable.name
end

## Helper functions

as_variable(name::Symbol, x)                   = constvar(name, x)
as_variable(name::Symbol, v::AbstractVariable) = v

as_variable(model, name::Symbol, x)                   = constvar(model, name, x)
as_variable(model, name::Symbol, v::AbstractVariable) = v
