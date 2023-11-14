function inverse_langevin(x::Float64)::Float64
    ccall((:inverse_langevin, FLAVIOSO_LIB), Float64, (Float64,), x)
end

function langevin(x::Float64)::Float64
    ccall((:langevin, FLAVIOSO_LIB), Float64, (Float64,), x)
end
