module Day22
include("utils.jl")
using .Utils
import .Utils: parse_input

using DataStructures: CircularBuffer

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
    d = Dict{NTuple{4, Int}, Int}()
    for n in x
        s = Set{NTuple{4, Int}}()
        b = CircularBuffer{Int}(4)
        prev = n % 10
        for _ in 1:3
            n = evolve(n)
            current = n % 10
            push!(b, current - prev)
            prev = current
        end
        for _ in 4:2000
            n = evolve(n)
            current = n % 10
            push!(b, current - prev)
            prev = current
            k = (b[1], b[2], b[3], b[4])
            k in s && continue
            push!(s, k)
            d[k] = get!(d, k, 0) + current
        end
    end
    return maximum(values(d))
end

end  # module
