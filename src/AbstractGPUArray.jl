module AbstractGPUArray

import Base: resize!
import Base: setindex!
import Base: getindex
import Base: map
import Base: foldl
import Base: length
import Base: eltype
import Base: endof
import Base: ndims
import Base: size
import Base: start
import Base: next
import Base: done



include("core.jl")
include("interface.jl")

export data
export init_ram
export resize


end # module
