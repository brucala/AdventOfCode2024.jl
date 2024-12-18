module Day18
include("utils.jl")
using .Utils
import .Utils: parse_input

using DataStructures

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    bytes = Point[]
    for line in splitlines(x)
        push!(bytes, tuple(toint.(split(line, ','))...))
    end
    return bytes
end

###
### Part 1
###

function solve1(x, ncorr=1024, len=70)
    corrupted = Set(x[1:ncorr])
    seen = Set{Point}()
    pq = PriorityQueue((0,0) => 0)

    while !isempty(pq)
        pos, nsteps = dequeue_pair!(pq)

        pos == (len, len) && return nsteps

        for d in ((0,1), (1,0), (-1,0), (0,-1))
            k = pos .+ d
            k in corrupted && continue
            k in seen && continue
            all((0,0) .<= k .<= (len, len)) || continue
            if haskey(pq, k)
                pq[k] > nsteps + 1 && (pq[k] = nsteps + 1)
            else
                enqueue!(pq, k => nsteps + 1)
            end
            push!(seen, pos)
        end
    end
    return 0
end

###
### Part 2
###

function solve2(x, len=70)
    nmin, nmax = 0, length(x)

    while nmax - nmin > 1
        nhalf = nmin + (nmax - nmin) ÷ 2
        n = solve1(x, nhalf, len)
        if n == 0
            nmax = nhalf
            continue
        else
            nmin = nhalf
            continue
        end
    end
    return x[nmax]
end

end  # module
