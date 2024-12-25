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
        push!(seen, k)

        for (i,d) in enumerate((dir, turn(dir), antiturn(dir)))
            p = pos .+ D[d]
            kk = (p, d)
            if x[p...] != '#' && kk ∉ seen
                add!(pq, kk, v+(i==1 ? 1 : 1001))
            end
        end
    end
end

###
### Part 2
###

function add!(pq::PriorityQueue, pos, dir, score, path)
    k = (pos, dir)
    if haskey(pq, k)
        score2 = pq[k][1]
        if score2 > score
            pq[k] = (score, path)
        elseif score2 == score
            union!(pq[k][2], path)
        end
    else
        enqueue!(pq, k => (score, path))
    end
end


function solve2(x)
    end_tile = findfirst(==('E'), x).I
    seen = Set{Tuple{Point, Dir}}()
    pq = PriorityQueue(
        Base.Order.By(first),
        (findfirst(==('S'), x).I, E) => (0, Set{Point}())
    )
    best = typemax(Int)
    tiles = Set{Point}()
    while !isempty(pq)
        k, v = dequeue_pair!(pq)
        pos, dir = k
        score, path = v

        score > best && break
        if pos == end_tile
            best = score
            union!(tiles, path)
            continue
        end

        push!(seen, (pos,dir))
        newpath = Set{Point}()
        for (i,d) in enumerate([dir, turn(dir), antiturn(dir)])
            p = pos .+ D[d]
            if x[p...] != '#' && (p,dir) ∉ seen && p ∉ path
                if isempty(newpath)
                    newpath = copy(path)
                    push!(newpath, pos)
                end
                add!(pq, p, d, score + (i==1 ? 1 : 1001), newpath)
            end
        end
    end
    return length(tiles) + 1
end

end  # module
