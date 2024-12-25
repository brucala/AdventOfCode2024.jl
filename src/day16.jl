module Day16
include("utils.jl")
using .Utils
import .Utils: parse_input

using DataStructures

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x)

###
### Part 1
###

@enum Dir N E S W
const D = Dict(N => (-1,0), E => (0,1), S => (1,0), W => (0,-1))
turn(d::Dir) = Dir(mod(Int(d) + 1, 4))
antiturn(d::Dir) = Dir(mod(Int(d) - 1, 4))

function add!(pq::PriorityQueue, k, v)
    if haskey(pq, k)
        pq[k] > v && (pq[k] = v)
    else
        enqueue!(pq, k => v)
    end
end

function solve1(x)
    end_tile = findfirst(==('E'), x).I
    seen = Set{Tuple{Point, Dir}}()
    pq = PriorityQueue((findfirst(==('S'), x).I, E) => 0)
    while !isempty(pq)
        k, v = dequeue_pair!(pq)
        pos, dir = k
        pos == end_tile && return v

        p = pos .+ D[dir]
        kk = (p, dir)
        if x[p...] != '#' && kk ∉ seen
            add!(pq, kk, v+1)
        end

        kk = (pos, turn(dir))
        kk ∉ seen && add!(pq, kk, v + 1000)

        kk = (pos, antiturn(dir))
        kk ∉ seen && add!(pq, kk, v + 1000)

        push!(seen, k)
    end
end

###
### Part 2
###

function solve2(x)
    end_tile = findfirst(==('E'), x).I
    seen = Set{Tuple{Point, Dir}}()
    pq = PriorityQueue((findfirst(==('S'), x).I, E, Point[]) => 0)
    best = typemax(Int)
    tiles = Set{Point}()
    while !isempty(pq)
        k, v = dequeue_pair!(pq)
        pos, dir, path = k
        push!(seen, (pos,dir))

        #@show pos, dir, v
        #@show pq
        v > best && break
        if pos == end_tile
            best = v
            union!(tiles, path)
            continue
        end

        ppath = Point[]
        for (i,d) in enumerate((dir, turn(dir), antiturn(dir)))
            p = pos .+ D[d]
            if x[p...] != '#' && (p,dir) ∉ seen && p ∉ path
                if isempty(ppath)
                    ppath = [path; pos]
                end
                kk = (p, d, ppath)
                add!(pq, kk, v + (i==1 ? 1 : 1001))
            end
        end
    end
    return length(tiles) + 1
end

end  # module
