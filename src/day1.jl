module Day1
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    l1, l2 = Int[], Int[]
    for line in splitlines(x)
        a, b = toint.(split(line))
        push!(l1, a)
        push!(l2, b)
    end
    return l1, l2
end

###
### Part 1
###

solve1(x) = sum(abs, sort(x[1]) .- sort(x[2]))

###
### Part 2
###

solve2(x) = sum(v * count(==(v), x[2]) for v in x[1])

end  # module
