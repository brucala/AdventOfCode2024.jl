module Day14
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

getpoint(x) = tuple(toint.(split(x[3:end], ','))...)

function parse_input(x::AbstractString)
    p, v = Point[], Point[]
    for line in splitlines(x)
        pp, vv = getpoint.(split(line, ' '))
        push!(p, pp)
        push!(v, vv)
    end
    return p,v
end

###
### Part 1
###

function solve1(x, size=(101,103), t=100)
    q = fill(0, 4)
    for (p,v) in zip(x...)
        pp = mod.(p .+ t .* v, size)
        if 2 * (pp[1]+1) < size[1]
            2 * (pp[2]+1) < size[2] && (q[1] += 1)
            2 * pp[2] > size[2] && (q[2] += 1)
        elseif 2 * pp[1] > size[1]
            2 * (pp[2]+1) < size[2] && (q[3] += 1)
            2 * pp[2] > size[2] && (q[4] += 1)
        end
    end
    return prod(q)
end

###
### Part 2
###

function draw(x, size)
    s = '+' * '-'^(size[1]) * "+\n"
    for r in 1:size[2]
        s *= '|'
        for c in 1:size[1]
            s *= (c-1,r-1) in x ? 'o' : '⋅'
        end
        s *= '|'
        s *= '\n'
    end
    s *= '+' * '-'^(size[1]) * '+'
    println(s)
end

function solve2(x, size=(101,103))
    for t in 1:10000
        q = solve1(x, size, t)
        #@show t, q, prod(q), prod(q) / (500/4)^4
        if prod(q) / (500/4)^4 < 0.25
            pp = [mod.(p .+ t .* v, size) for (p,v) in zip(x...)]
            #draw(pp, size)
            #println(t, ", ", prod(q) / (500/4)^4)
            return t
        end
    end
end

end  # module
