export diageye

using StatsFuns: logistic
using StatsFuns: softmax, softmax!
using LoopVectorization

import LinearAlgebra

diageye(::Type{T}, n::Int) where {T <: Real} = Matrix{T}(I, n, n)
diageye(n::Int)                              = diageye(Float64, n)

function normalize_sum(x::Array{Float64, 1})
    x ./ sum(x)
end

const sigmoid = logistic

dtanh(x) = 1 - tanh(x)^2

"""
    mirrorlog(x)

Returns `log(1 - x)`.
"""
mirrorlog(x) = log(1 - x)

"""
    xtlog(x)

Returns `x * log(x)`.
"""
xtlog(x) = x * log(x)

"""
    negate_inplace!(A)

Returns `-A`, modifying and reusing `A` storage if possible.

See also: [`mul_inplace!`](@ref)
"""
function negate_inplace! end

negate_inplace!(A::AbstractArray) = -A
negate_inplace!(A::Real)          = -A
negate_inplace!(A::Array)         = map!(-, A, A)

"""
    mul_inplace!(alpha, A)

Returns `alpha * A`, modifying and reusing `A` storage if possible.

See also: [`negate_inplace!`](@ref)
"""
function mul_inplace! end

mul_inplace!(alpha, A::AbstractArray) = alpha * A
mul_inplace!(alpha, A::Real) = alpha * A
mul_inplace!(alpha::T, A::Array{T}) where {T <: Real} = lmul!(alpha, A)

"""
    rank1update(A, x)
    rank1update(A, x, y)

Helper function for A + x * y'. Uses optimised BLAS version for AbstractFloats and fallbacks to a generic implementation in case of differentiation
"""
function rank1update end

rank1update(A::AbstractMatrix, x::AbstractVector)                    = rank1update(eltype(A), eltype(x), eltype(x), A, x, x)
rank1update(A::AbstractMatrix, x::AbstractVector, y::AbstractVector) = rank1update(eltype(A), eltype(x), eltype(y), A, x, y)

rank1update(A::Real, x::Real)          = rank1update(A, x, x)
rank1update(A::Real, x::Real, y::Real) = A + x * y

function rank1update(
    ::Type{T},
    ::Type{T},
    ::Type{T},
    A::Matrix,
    x::Vector,
    y::Vector
) where {T <: LinearAlgebra.BlasFloat}
    return LinearAlgebra.BLAS.ger!(one(T), x, y, copy(A))
end

function rank1update(
    ::Type{T1},
    ::Type{T2},
    ::Type{T3},
    A::AbstractMatrix,
    x::AbstractVector,
    y::AbstractVector
) where {T1 <: Real, T2 <: Real, T3 <: Real}
    T = promote_type(T1, T2, T3)
    B = Matrix{T}(undef, size(A))
    return rank1update!(B, A, x, y)
end

function rank1update!(B::AbstractMatrix, A::AbstractMatrix, x::AbstractVector, y::AbstractVector)
    sz = size(A)
    @inbounds for k2 in 1:sz[2]
        yk2 = y[k2]
        @inbounds for k1 in 1:sz[1]
            B[k1, k2] = A[k1, k2] + x[k1] * yk2
        end
    end
    return B
end

"""
    mul_trace(A, B)

Computes tr(A * B) without allocating A * B.
"""
function mul_trace end

mul_trace(A::Real, B::Real) = A * B

function mul_trace(A::AbstractMatrix, B::AbstractMatrix)
    sA, sB = size(A), size(B)
    @assert (sA === sB) && (length(sA) === 2) && (first(sA) === last(sA))
    result = zero(promote_type(eltype(A), eltype(B)))
    n = first(sA)
    @turbo for i in 1:n
        for j in 1:n
            result += A[i, j] * B[j, i]
        end
    end
    return result
end

"""
    v_a_vT(v, a)

Computes v*a*v^T with a single allocation.
"""
function v_a_vT(v::AbstractVector, a::Real)
    T      = promote_type(eltype(v), typeof(a))
    result = zeros(T, length(v), length(v))
    mul!(result, v, v', a, one(T))
    return result
end

function v_a_vT(v, a)
    result = v * v'
    result *= a
    return result
end

"""
    v_a_vT(v1, a, v2)

Computes v1*a*v2^T with a single allocation.
"""
function v_a_vT(v1::AbstractVector, a::Real, v2::AbstractVector)
    T      = promote_type(eltype(v1), typeof(a), eltype(v2))
    result = zeros(T, length(v1), length(v2))
    mul!(result, v1, v2', a, one(T))
    return result
end

function v_a_vT(v1, a, v2)
    result = v1 * v2'
    result *= a
    return result
end
