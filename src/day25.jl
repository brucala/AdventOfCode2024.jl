module Day25
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    #return x
    locks, keys = NTuple{5, Int}[], NTuple{5, Int}[]
    for block in split(x, "\n\n")
        g = getgrid(block)
        t = Tuple(sum(==('#'),g, dims=1))
        if g[1, 1] == '#'
            push!(locks, t)
        else
            push!(keys, t)
        end
    end
    return locks, keys
end

###
### Part 1
###

solve1(x) = sum(all(<=(7), l .+ k) for l in x[1], k in x[2])


###
### Part 2
###

function solve2(x)
end

end  # module
