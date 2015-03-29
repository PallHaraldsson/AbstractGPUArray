abstract GPUArray{T, NDim}

#=
immutable GPUArray{T, NDim, GPUBuff <: GPUBuffer} <: DenseArray{T, NDim}
    buff::GPUBuff{T, NDim}
    size::NTuple{Int, NDim}
end

immutable BufferedGPUArray{GPUArr <: GPUArray}
    buff::GPUBuff{T, NDim}
    ram::Array{T, NDim}
end
=#

length(A::GPUArray)                                     = prod(size(A))
eltype{T, NDim}(b::GPUArray{T, NDim}) = T
endof(A::GPUArray)                                      = length(A)
ndims{T, NDim}(A::GPUArray{T, NDim})  = NDim
size(A::GPUArray)                                       = A.size
size(A::GPUArray, i::Integer)                           = A.size[i]
start(b::GPUArray)                                      = 1
next(b::GPUArray, state::Integer)                       = (A[state], state+1)
done(b::GPUArray, state::Integer)                       = length(A) < state


function resize!{T, NDim}(A::GPUArray{T, NDim}, newdims::NTuple{NDim, Int})
    newdims == size(A) && return A
    checkbounds(A, newdims)
    gpu_resize!(A, newdims)
    A
end


function checkdimensions(value::Array, ranges::Union(Integer, UnitRange)...)
    array_size   = size(value)
    indexes_size = map(length, ranges)

    (array_size != indexes_size) && throw(DimensionMismatch("asigning a $array_size to a $(indexes_size) location"))
    true
end
function setindex!{I <: Integer, T, N}(A::GPUArray, value::Array{T, N}, indexes::Union(UnitRange, I)...)
    ranges = map(indexes) do val
        isa(val, Integer) && return val:val
        val # can only be unitrange        
    end
    setindex!(A, value, ranges...)
end
function setindex!{T, N}(A::GPUArray{T, N}, value::Array{T, N}, ranges::UnitRange...)
    checkbounds(A, ranges...)
    checkdimensions(value, range...)
    gpu_setindex!(A, value, ranges...)
end

function getindex{T, N}(A::GPUArray{T, N}, ranges::UnitRange...)
    checkbounds(A, ranges...)
    gpu_getindex(A, ranges...)
end