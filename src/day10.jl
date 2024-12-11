module Day10
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x, fmap=toint)

###
### Part 1
###

struct TopoMap
    map::Matrix{Int}
    trailheads::Matrix{Dict{Point, Int}}
end
TopoMap(map) = TopoMap(map, similar(map, Dict{Point, Int}))

function trailheads(m::TopoMap, p::Point)
    all((1,1) .<= p .<= size(m.map)) || return Dict{Point, Int}()

    isassigned(m.trailheads, p...) && return m.trailheads[p...]

    th = Dict{Point, Int}()
    m.trailheads[p...] = th

    if m.map[p...] == 9
        th[p] = 1
        #push!(th, (p, 1))
        return th
    end

    for d in ((0,1) , (1,0), (-1, 0), (0, -1))
        p2 = p .+ d
        all((1,1) .<= p2 .<= size(m.map)) || continue
        m.map[p2...] == m.map[p...] + 1 || continue
        for (k,v) in trailheads(m, p2)
            th[k] = get(th, k , 0) + v
            #m.trailheads[p...] = m.trailheads[p...] ∪ trailheads(m, p2)
        end
    end
    return m.trailheads[p...]
end

ntrailheads(m::TopoMap, p::Point) = length(trailheads(m, p))

function score(m::TopoMap, f=ntrailheads)
    score = 0
    for p in findall(==(0), m.map)
        score += f(m, p.I)
    end
    return score
end

solve1(x) = score(TopoMap(x))

###
### Part 2
###

rating(m::TopoMap, p::Point) = sum(values(trailheads(m, p)))

solve2(x) = score(TopoMap(x), rating)

end  # module
