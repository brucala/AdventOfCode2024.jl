module Day6
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###


@enum Dir N E S W

dir(d::Char) = Dict('^' => N, '>' => E, 'v' => S, '<' => W)[d]
turn(d::Dir) = Dir(mod(Int(d) + 1, 4))

mutable struct Maze
    size::Point
    obstacles::Set{Point}
    hobstacles::Dict{Int, Vector{Int}}
    vobstacles::Dict{Int, Vector{Int}}
    guard_pos::Point
    guard_dir::Dir
    extra_obstacle::Point
end

Maze(m::Maze) = Maze(m.size, m.obstacles, m.hobstacles, m.vobstacles, m.guard_pos, m.guard_dir, m.extra_obstacle)

function Maze(lines)
    size = length(lines), length(lines[1])
    obstacles = Set{Point}()
    hobstacles = Dict{Int, Vector{Int}}()
    vobstacles = Dict{Int, Vector{Int}}()
    guard_pos = (0,0)
    guard_dir = N
    for (r, line) in enumerate(lines)
        for (c, x) in enumerate(line)
            x == '.' && continue
            if x == '#'
                push!(obstacles, (r, c))
                push!(get!(hobstacles, r, []), c)
                push!(get!(vobstacles, c, []), r)
            else
                guard_pos = (r, c)
                guard_dir = dir(x)
            end
        end
    end
    return Maze(size, obstacles, hobstacles, vobstacles, guard_pos, guard_dir, (-1,-1))
end

parse_input(x::AbstractString) = return Maze(splitlines(x))

###
### Part 1
###

pos(m::Maze) = m.guard_pos
dir(m::Maze) = m.guard_dir
posdir(m::Maze) = (pos(m), dir(m))
turn!(m::Maze) = (m.guard_dir = turn(m.guard_dir))
move!(m::Maze, p::Point) = (m.guard_pos = p)

#Base.in(p::Point, m::Maze) = p[1] <= 0 || p[1] > m.size[1] || p[2] <= 0 || p[2] > m.size[2] || p in m.obstacles
#Base.in(p::Point, m::Maze) =  1 <= p[1] <= m.size[1] && 1 <= p[2] <= m.size[2]
Base.in(p::Point, m::Maze) =  all((1,1) .< p .<= m.size)

isobstacle(m::Maze, p::Point) = p in m.obstacles || p == m.extra_obstacle

const D = Dict(N => (-1,0), E => (0,1), S => (1,0), W => (0,-1))
step(p::Point, d::Dir) = p .+ D[d]
#=
function step!(m::Maze)
    p = step(pos(m), dir(m))
    p in m || return false
    if isobstacle(m, p)
        turn!(m)
        return true
    end
    move!(m, p)
    return true
end
function step!(m::Maze)
    p = step(pos(m), dir(m))
    p in m || return false
    while !isobstacle(m, p)
        move!(m, p)
        p = step(pos(m), dir(m))
        p in m || return false
    end
    turn!(m)
    return true
end
=#

function step!(m::Maze)
    #@show posdir(m)
    #@show m.vobstacles
    #@show m.hobstacles
    if dir(m) in (E, W)
        d = m.hobstacles
        k, v = pos(m)
        if haskey(d, k)
            if dir(m) == W
                obs = filter(<(v), d[k])
                m.extra_obstacle[1] == k && m.extra_obstacle[2] < v && push!(obs, m.extra_obstacle[2])
                if !isempty(obs)
                    p = (k, maximum(obs) + 1)
                    move!(m, p)
                    turn!(m)
                    return true
                end
            else
                obs = filter(>(v), d[k])
                m.extra_obstacle[1] == k && m.extra_obstacle[2] > v && push!(obs, m.extra_obstacle[2])
                #@show d
                #@show k,v, d[k], obs
                if !isempty(obs)
                    p = (k, minimum(obs) - 1)
                    move!(m, p)
                    turn!(m)
                    return true
                end
            end
        end
        p = (k, dir(m) == W ? 1 : m.size[2])
        move!(m, p)
        return false
    else
        d = m.vobstacles
        v, k = pos(m)
        if haskey(d, k)
            if dir(m) == N
                obs = filter(<(v), d[k])
                m.extra_obstacle[2] == k && m.extra_obstacle[1] < v && push!(obs, m.extra_obstacle[1])
                if !isempty(obs)
                    p = (maximum(obs) + 1, k)
                    move!(m, p)
                    turn!(m)
                    return true
                end
            else
                obs = filter(>(v), d[k])
                m.extra_obstacle[2] == k && m.extra_obstacle[1] > v && push!(obs, m.extra_obstacle[1])
                if !isempty(obs)
                    p = (minimum(obs) - 1, k)
                    move!(m, p)
                    turn!(m)
                    return true
                end
            end
        end
        p = (dir(m) == E ? 1 : m.size[1], k)
        move!(m, p)
        return false
    end
end

between_positions(p1, p2) = ((i,j) for i in range(minmax(p1[1],p2[1])...), j in range(minmax(p1[2],p2[2])...))

function positions(x)
    m = Maze(x)  # copy
    p = pos(m)
    positions = Set()
    while step!(m)
        p2 = pos(m)
        for pp in between_positions(p, p2)
            push!(positions, pp)
        end
        p = p2
    end
    p2 = pos(m)
    for pp in between_positions(p, p2)
        push!(positions, pp)
    end
    return positions
end

solve1(x) = length(positions(x))

###
### Part 2
###

Maze(m::Maze, extra::Point) = Maze(m.size, m.obstacles, m.hobstacles, m.vobstacles, m.guard_pos, m.guard_dir, extra)

function solve2(x)

    pp = positions(x)

    n = 0
    for (i,j) in pp

        (i, j) == x.guard_pos && continue

        (isobstacle(x, (i,j)) || (i,j) == pos(x)) && continue
        m = Maze(x, (i,j))
        visited = Set{Tuple{Point, Dir}}([posdir(m)])
        while step!(m)
            if posdir(m) in visited
                n += 1
                break
            end
            push!(visited, posdir(m))
        end
    end
    return n
end

end  # module
