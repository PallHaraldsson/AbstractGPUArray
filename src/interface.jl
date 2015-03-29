
# Interface:
gpu_data(t)      = error("gpu_data not implemented for: $(typeof(t)). This happens, when you call data on an array, without implementing the GPUArray interface")
gpu_resize!(t)   = error("gpu_resize! not implemented for: $(typeof(t)). This happens, when you call resize! on an array, without implementing the GPUArray interface")
gpu_getindex(t)  = error("gpu_getindex not implemented for: $(typeof(t)). This happens, when you call getindex on an array, without implementing the GPUArray interface")
gpu_setindex!(t) = error("gpu_setindex! not implemented for: $(typeof(t)). This happens, when you call setindex! on an array, without implementing the GPUArray interface")
max_dim(t)       = error("max_dim not implemented for: $(typeof(t)). This happens, when you call setindex! on an array, without implementing the GPUArray interface")
