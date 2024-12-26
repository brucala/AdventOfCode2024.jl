module Day19
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    patterns, designs = split(x, "\n\n")
    return Set{String}(split(patterns, ", ")), splitlines(designs)
end

###
### Part 1
###

function ispossible(design, patterns, D)
    haskey(D, design) && return D[design]
    for p in patterns
        startswith(design, p) || continue
        ispossible(design[length(p)+1:end], patterns, D) || continue
        D[design] = true
        return true
    end
    D[design] = false
    return false
end

function solve1(x)
    patterns, designs = x
    D = Dict(p => true for p in patterns)
    return sum(d -> ispossible(d, patterns, D), designs)
end

###
### Part 2
###

function nways(design, patterns, D)
    haskey(D, design) && return D[design]
    isempty(design) && return 1
    n = 0
    for p in patterns
        startswith(design, p) || continue
        n += nways(design[length(p)+1:end], patterns, D)
    end
    D[design] = n
    return n
end

function solve2(x)
    patterns, designs = x
    D = Dict{String, Int}()
    return sum(d -> nways(d, patterns, D), designs)
end

end  # module
