# Original function
function f(x::Float64)
    return sin(x) * exp(cos(x))
end

# Derivative function
function df_exact(x::Float64)
    return exp(cos(x)) * (cos(x) - sin(x)^2)
end

# Estimate of the derivative function by central difference
function df_diff(func, x, hs)
    return (func.(x .+ hs) .- func.(x .- hs)) ./ (2.0 .* hs)
end

hs = 10.0 .^ collect(-15:0)

x0 = 1.0

g1 = df_exact.(x0)
g2 = df_diff(f, x0, hs)

err = abs.(g1 .- g2)

using Plots
plot(hs, err, xscale = :log10, yscale=:log10, markershape=:circle,
        lw=1, xlimits=(1e-20,1), legend=:topleft)
xlabel!("h")
ylabel!("Error")
savefig("trunction_err.png")
