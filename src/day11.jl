module Day11
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = toint.(split(x))

###
### Part 1
###

function blink(x::Int)
    x == 0 && return 1
    s = string(x)
    isodd(length(s)) && return 2024x
    i = length(s) ÷ 2
    return toint.([s[1:i], s[i+1:end]])
end

function blink(x::Vector{Int})
    y = Int[]
    for i in x
        append!(y, blink(i))
    end
    return y
end

#= with no memoization
function solve1(x, n=25)
    x = copy(x)
    for _ in 1:n
        x = blink(x)
    end
    return length(x)
end
=#

solve1(x) = solve2(x, 25)

###
### Part 2
###

function nblink(x::Int, n::Int, MEMO)
    p = (x,n)
    haskey(MEMO, p) && return MEMO[p]

    if n == 1
        MEMO[p] = x == 0  || isodd(length(string(x))) ? 1 : 2
        return MEMO[p]
    end

    if x == 0
        MEMO[p] = nblink(1, n-1, MEMO)
    else
        s = string(x)

        if isodd(length(s))
            MEMO[p] = nblink(2024x, n-1, MEMO)
        else
            i = length(s) ÷ 2
            a, b = toint.([s[1:i], s[i+1:end]])

            if a != b
                MEMO[p] = nblink(a, n-1, MEMO) + nblink(b, n-1, MEMO)
            else
                MEMO[p] = nblink(a, n-1, MEMO) * 2
            end
        end
    end
    return MEMO[p]
end

function solve2(x, n=75)
    MEMO = Dict{Point, Int}()
    res = 0
    for i in x
        res += nblink(i, n, MEMO)
    end
    return res
end

end  # module
