abstract GPUArray{T, ElementNDim, NDim, NoRam, }


#helper for initiazing ram data
function init_ram(data::Ptr, dims, keepinram::Bool)
    if keepinram
        (data == C_NULL) && return zeros(T, dims...) # If C_NULL array is uninitialized
        return copy(pointer_to_array(data, tuple(dims...))) # otherwise copy original array
    end
    return obj = Array(T, (dims*0)...)
end

function data(A::GPUArray)
    isinram(A) && return A.data
    return gpu_data(A)
end


resize(data::Array{T, 1}, newdims) = resize!(data, newdims) # bad style!! But couldn't figure out how to best switch between inplace resize!
function resize{NDIM}(data::Array{T, NDIM}, newdims)
    ranges = map(zip(newdims, size(data))) do dims
       1:min(dims...) # create a range, which only goes to the smaller dim
    end
    tmp = Array(T, newdims...)
    tmp[ranges...] = data[ranges...] # copy old data
    return tmp
end

function Base.resize!(A::GPUArray, newdims)
    newdims == size(A) && return
    gpu_resize!(A, newdims)
    isinram(A) && resize(data(A), newdims)
    nothing
end


function checkdimensions(value::Array, ranges::Union(Integer, UnitRange)...)
    array_size   = size(value)
    indexes_size = map(length, ranges)

    (array_size != indexes_size) && throw(DimensionMismatch("asigning a $array_size to a $(indexes_size) location"))
    true
end
function Base.setindex!{I <: Integer}(A::GPUArray, value::Array{T, N}, indexes::Union(UnitRange, I)...)
    ranges = map(indexes) do val
        isa(val, Integer) && return val:val
        val # can only unitrange        
    end
    setindex!(A, value, ranges)
end
function Base.setindex!{T, C, N, NoRam}(A::GPUArray{T, C, N, NoRam}, value::Array{T, N}, ranges::UnitRange...)
    checkbounds(b, ranges...)
    checkdimensions(value, range...)
    !NoRam && setindex!(A, value, ranges...)
    gpu_setindex!(b, value, ranges...)
end

function Base.getindex{T, C, N, NoRam}(A::GPUArray{T, C, N, NoRam}, ranges::UnitRange...)
    checkbounds(b, ranges...)
    ifelse(NoRam, gpu_getindex(b, ranges...), getindex(A, value, ranges...)
end