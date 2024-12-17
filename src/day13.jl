module Day13
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function getXY(x, pad1, pad2)
    x, y = split(x[pad1:end], ',')
    return toint.((x[pad2:end], y[pad2:end]))
end
getbutton(x) = getXY(x, 10, 3)

function parse_input(x::AbstractString)
    claws = NTuple{3, Point}[]
    #claws = NTuple{3, Tuple{BigInt, BigInt}}[]
    for block in split(x, "\n\n")
        lines = splitlines(block)
        @assert lines[1][8] == 'A'
        @assert lines[2][8] == 'B'
        a, b = getbutton.(lines[1:2])
        prize = getXY(lines[3], 7, 4)
        push!(claws, (a,b,prize))
    end
    return claws
end

###
### Part 1
###

function solve(a, b, p)
    d = a[1] * b[2] - a[2] * b[1]
    # if parallel
    if d == 0
        a[1] * p[2] == a[2] * p[1] || return 0  # not parallel with prize
        return minimum(filter(isinteger, p[1] .// [a[1], b[1]]), init=0)
    end
    n = (p[1] * b[2] - p[2] * b[1]) // d
    isinteger(n) || n<=0 || return 0
    m = (p[2] * a[1] - p[1] * a[2]) // d
    isinteger(m) || m<= 0 || return 0
    (n <= 0 || m <= 0) && return 0
    return 3n.num + m.num
end

solve1(x::NTuple) = solve(x...)
solve1(x) = sum(solve1, x)

###
### Part 2
###

solve2(x::NTuple) = solve(x[1], x[2], 10000000000000 .+ x[3])
solve2(x) = sum(solve2, x)

end  # module
