module Day7
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    calibrations = Tuple{Int, Vector{Int}}[]
    for line in splitlines(x)
        i = findfirst(':', line)
        a = toint(line[1:i-1])
        b = toint.(split(line[i+1:end]))
        push!(calibrations, (a,b))
    end
    return calibrations
end

###
### Part 1
###

function test_calibration(a, b, part2)
    length(b) == 1 && return a == b[1]
    s = sum(b)
    s == a && return true
    aa, bb = b[1], b[2:end]
    a >= aa || return false
    test_calibration(a-aa, bb, part2) && return true
    a % aa == 0 && test_calibration(a ÷ aa, bb, part2) && return true
    part2 || return false
    sa, saa = string.([a, aa])
    if length(sa) > length(saa) && sa[end-length(saa)+1:end] == saa
        test_calibration(toint(sa[1:end-length(saa)]), bb, part2) && return true
    end
    return false
end

test_calibration(x, part2) = test_calibration(x[1], reverse(x[2]), part2)

solve1(x, part2=false) = sum(x-> x[1], filter(x -> test_calibration(x, part2), x))

###
### Part 2
###

solve2(x) = solve1(x, true)

end  # module
