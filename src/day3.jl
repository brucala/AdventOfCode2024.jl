module Day3
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = x

###
### Part 1
###

mul(x) = prod(toint.(split(x.match[5:end-1], ',')))
mulmatches(x) = eachmatch(r"mul\(\d{1,3},\d{1,3}\)", x)

solve1(x) = sum(mul, mulmatches(x))

###
### Part 2
###

function solve2(x)
    i = 1
    s = 0
    while i < length(x)
        j = something(findnext("don't()", x, i), length(x):length(x)).start

        s += sum(mul, mulmatches(x[i:j]))

        i = findnext("do()", x, j)
        isnothing(i) && break
        i = i.stop
    end
    return s
end

end  # module
