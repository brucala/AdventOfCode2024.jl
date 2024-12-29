module Day22
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = parse_ints(x)

###
### Part 1
###

function evolve(x)
    x = (prune ∘ mix)(64x, x)
    x = (prune ∘ mix)(x ÷ 32, x)
    x = (prune ∘ mix)(2048x, x)
end

mix(a, b) = a ⊻ b
prune(x) = mod(x, 16777216)

function solve1(x)
    for _ in 1:2000
        x = evolve.(x)
    end
    sum(x)
end

###
### Part 2
###

function solve2(x)
    d = Dict{NTuple{4, Int8}, Int16}()
    for n in x
        s = Set{NTuple{4, Int8}}()
        prev = n % 10
        k = (0,0,0,0)
        for i in 1:2000
            n = evolve(n)
            current = n % 10
            k = (k[2], k[3], k[4], current - prev)
            prev = current
            i<4 && continue
            k in s && continue
            push!(s, k)
            d[k] = get!(d, k, 0) + current
        end
    end
    return maximum(values(d))
end

end  # module
