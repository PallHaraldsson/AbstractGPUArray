module AbstractGPUArray

import Base: resize!, setindex!, getindex, map, foldl

include("interface.jl")
include("core.jl")

export data
export init_ram
export resize


end # module
