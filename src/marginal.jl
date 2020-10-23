export Marginal, getdata, as_marginal

using Distributions
using Rocket

import Distributions: mean, var, std, cov, entropy
import Base: ndims, precision
import Base: map

struct Marginal{D}
    data :: D
end

getdata(marginal::Marginal) = marginal.data

## Marginal

Distributions.mean(marginal::Marginal)    = Distributions.mean(getdata(marginal))
Distributions.var(marginal::Marginal)     = Distributions.var(getdata(marginal))
Distributions.std(marginal::Marginal)     = Distributions.std(getdata(marginal))
Distributions.cov(marginal::Marginal)     = Distributions.cov(getdata(marginal))
Distributions.entropy(marginal::Marginal) = Distributions.entropy(getdata(marginal))

Base.precision(marginal::Marginal) = precision(getdata(marginal))
Base.ndims(marginal::Marginal)     = ndims(getdata(marginal))

logmean(marginal::Marginal)     = log(mean(marginal))
inversemean(marginal::Marginal) = inv(mean(marginal))

## Utility functions

as_marginal(data)               = Marginal(data)
as_marginal(marginal::Marginal) = marginal

const __as_marginal_operator = Rocket.map(Marginal, as_marginal)

as_marginal() = __as_marginal_operator

function __reduce_to_marginal(messages)
    return as_marginal(reduce_messages(messages))
end

const reduce_to_marginal = Rocket.map(Marginal, __reduce_to_marginal)

## Marginal observable

struct MarginalObservable <: Subscribable{Marginal}
    subject :: Rocket.ReplaySubjectInstance{ Marginal, Subject{ Marginal,AsapScheduler,AsapScheduler } }
    stream  :: LazyObservable{Marginal}
end

MarginalObservable() = MarginalObservable(ReplaySubject(Marginal, 1), lazy(Marginal))

function Rocket.on_subscribe!(observable::MarginalObservable, actor)
    return subscribe!(observable.stream, actor)
end

function connect!(marginal::MarginalObservable, source)
    set!(marginal.stream, source |> multicast(marginal.subject) |> ref_count())
    return nothing
end

function setmarginal!(marginal::MarginalObservable, value)
    next!(marginal.subject, as_marginal(value))
    return nothing
end