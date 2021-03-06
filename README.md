# AbstractGPUArray

[![Join the chat at https://gitter.im/JuliaGPU/AbstractGPUArray](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/JuliaGPU/AbstractGPUArray?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/SimonDanisch/AbstractGPUArray.jl.svg?branch=master)](https://travis-ci.org/SimonDanisch/AbstractGPUArray.jl)

An abstract interface for GPU arrays.
Like this, similar traits can be shared between opengl, opencl or cuda.
Also, we can standardize the tests for the GPU array.
We might think about a standardized array test for GPUArrays, julia arrays, FixedSizeArrays, etc. This could greatly improve stability of every array like construct.
While we're at it, we might as well couple it with a benchmark of all the different array types, which can be used for clarifying which array should be used in which scenario.
