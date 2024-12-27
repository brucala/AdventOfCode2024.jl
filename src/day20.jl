module Day20
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Maze
    grid::Matrix{Char}
    maze::Dict{Point,Int}
end
Maze(grid) = Maze(grid, getmaze(grid))

function getmaze(x)
    current = findfirst(==('S'), x).I
    finish = findfirst(==('E'), x).I
    path = Dict(current => 0)
    prev = (0,0)
    while current != finish
        for d in ((1,0), (0,1), (-1,0), (0,-1))
            p = current .+ d
            (x[p...] == '#' || p == prev) && continue
            path[p] = path[current] + 1
            prev, current = current, p
            break
        end
    end
    return path
end

parse_input(x::AbstractString) = Maze(getgrid(x))

### Part 1
###

function solve1(x, saves=100)
    maze = x.maze
    n = 0
    for i in 2:(size(x.grid)[1]-1), j in 2:(size(x.grid)[2]-1)
        x.grid[i,j] != '#' && continue
        if x.grid[i+1, j] != '#' && x.grid[i-1, j] != '#'
            abs(maze[(i+1, j)] - maze[(i-1, j)])-2 >= saves && (n += 1)
        elseif x.grid[i, j+1] != '#' && x.grid[i, j-1] != '#'
            abs(maze[(i, j+1)] - maze[(i, j-1)])-2 >= saves && (n += 1)
        end
    end
    return n
end

###
### Part 2
###

function solve2(x, saves=100)
    maze = copy(x.maze)
    n = 0
    while !isempty(maze)
        (k1, v1) = pop!(maze)
        for (k2,v2) in maze
            #abs(v2 - v1) - 2 < saves && continue
            d = sum(abs.(k1 .- k2))
            (d > 20 || abs(v2 - v1) - d < saves) && continue
            n += 1
        end
    end
    return n
end

end  # module
