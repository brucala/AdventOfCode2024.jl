module Day15
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

mutable struct Grid
    grid::Matrix{Char}
    robot::Point
    moves::String
end

function Grid(x::AbstractString)
    grid, moves = split(x, "\n\n")
    g = getgrid(grid)
    robot = findfirst(==('@'), g)
    g[robot] = '.'
    return Grid(g, robot.I, moves)
end
Grid(g::Grid) = Grid(copy(g.grid), g.robot, g.moves)

function Base.show(io::IO, g::Grid)
    s = ""
    for i in 1:size(g.grid)[1]
        for j in 1:size(g.grid)[2]
            if (i, j) == g.robot
                s *= '@'
            else
                s *= g.grid[i,j]
            end
        end
        s *= '\n'
    end
    print(io, s)
end

parse_input(x::AbstractString) = Grid(x)

###
### Part 1
###

@enum Dir N E S W

const D = Dict(
    '^' => N,
    '>' => E,
    'v' => S,
    '<' => W,
)

delta(d::Dir) = delta(Val(d))
delta(::Val{N}) = (-1, 0)
delta(::Val{E}) = (0, 1)
delta(::Val{S}) = (1, 0)
delta(::Val{W}) = (0, -1)

function move!(g::Grid, d::Dir)
    Δ = delta(d)
    p = g.robot .+ Δ
    g.grid[p...] == '#' && return g
    if g.grid[p...] == '.'
        g.robot = p
        return g
    end
    p2 = p
    while g.grid[p2...] == 'O'
        p2 = p2 .+ Δ
    end
    g.grid[p2...] == '#' && return g

    g.robot = p
    g.grid[p...] = '.'
    g.grid[p2...] = 'O'

    return g
end

function move(g::Grid, f=move!)
    g = Grid(g)
    #println(g)
    for m in g.moves
        m == '\n' && continue
        f(g, D[m])
        # println("($i) Move $m:")
        # println(g)
    end
    return g
end

function gps(g::Grid)
    score = 0
    for p in CartesianIndices(g.grid)
        g.grid[p] in "O[" || continue
        score += 100 * (p[1] - 1) + p[2] - 1
    end
    return score
end

solve1(x) = gps(move(x))

###
### Part 2
###

function move2!(g::Grid, d::Dir)
    Δ = delta(d)
    p = g.robot .+ Δ
    c = g.grid[p...]
    c == '#' && return g
    if c == '.'
        g.robot = p
        return g
    end
    if d in (E, W)
        p2 = p
        while g.grid[p2...] in "[]"
            p2 = p2 .+ 2 .* Δ
        end
        g.grid[p2...] == '#' && return g

        g.robot = p
        len = abs(p2[2]-p[2])
        step = p2[2]>p[2] ? 1 : -1
        r1 = range(p[2], length=len, step=step)
        r2 = range((p .+ Δ)[2], length=len, step=step)
        #@show r1, r2, g.grid[p[1],r2],  g.grid[p[1], r1]
        g.grid[p[1], r2] = g.grid[p[1], r1]
        g.grid[p...] = '.'

        return g
    end

    ps = [Set([p])]
    push!(ps[end], c == '[' ? p .+ delta(E) : p .+ delta(W))

    while true
        pp = map(x -> x .+ Δ, collect(ps[end]))
        any(x -> g.grid[x...] == '#', pp) && return g
        all(x -> g.grid[x...] == '.', pp) && break
        push!(ps, Set())
        for p in pp
            c = g.grid[p...]
            c == '.' && continue
            push!(ps[end], p)
            push!(ps[end], c == '[' ? p .+ delta(E) : p .+ delta(W))
        end
    end
    g.robot = p
    for s in reverse(ps)
        for p in s
            g.grid[(p .+ Δ)...] = g.grid[p...]
            g.grid[p...] = '.'
        end
    end
    return g
end

function expand(g::Grid)
    grid2 = similar(g.grid, size(g.grid) .* (1, 2))
    for p in CartesianIndices(g.grid)
        i, j = p.I
        c = g.grid[p]
        grid2[i, 2j-1:2j] = c in ('#', '.') ? [c, c] : ['[', ']']
    end
    robot = (g.robot[1] , g.robot[2] * 2 - 1)
    return Grid(grid2, robot, g.moves)
end

solve2(x) = gps(move(expand(x), move2!))

end  # module
