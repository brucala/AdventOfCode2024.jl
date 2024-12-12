module Day12
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x)

###
### Part 1
###

function area_perimeter(x, i, D)
    haskey(D,i) && return D[i]

    D[i] = (0, 0)
    area, perimeter = 1, 4
    for i2 in i .+ CartesianIndex.([(1,0), (0,1), (-1,0), (0,-1)])
        (checkbounds(Bool, x, i2) && x[i2] == x[i]) || continue
        perimeter -= 1

        haskey(D, i2) && continue

        a, p = area_perimeter(x, i2, D)
        area += a
        perimeter += p
    end
    D[i] = (area, perimeter)
    return D[i]
end

function solve1(x)
    D = Dict{CartesianIndex{2}, Point}()
    price = 0
    for i in CartesianIndices(size(x))
        haskey(D, i) && continue
        price += prod(area_perimeter(x, i, D))
    end
    return price
end

###
### Part 2
###

function area_sides(x, i, D)
    haskey(D,i) && return D[i]

    dirs = CartesianIndex.([(1,0), (0,1), (-1,0), (0,-1)])
    neighbours = [
        (j,i2)
        for (j,i2) in enumerate(i .+ dirs)
        if checkbounds(Bool, x, i2) && x[i2] == x[i]
    ]

    sides = [1,1,1,1]
    for (j,_) in neighbours
        sides[j] -= 1
    end

    D[i] = (0,0,0,0,0)

    area = 1
    for (j, i2) in neighbours
        (checkbounds(Bool, x, i2) && x[i2] == x[i]) || continue

        if !haskey(D, i2)
            a, s... = area_sides(x, i2, D)
            area += a
            sides[j] += sum(s)
        end
    end
    for (j, i2) in neighbours, k in (1,3)
        j2 = mod1(j+k,4)

        if D[i2][j2+1] == 1
            i3 = i2 .+ dirs[j2]
            i4 = i .+ dirs[j2]
            haskey(D,i3) && x[i3] == x[i] && continue
            haskey(D,i4) && x[i4] == x[i] && continue
            D[i2][j2+1] == sides[j2] ==1 || continue
            sides[j] -= 1
        end

    end
    D[i] = (area, sides...)
    return D[i]
end

function solve2(x)
    seen = Set{CartesianIndex{2}}()
    price = 0
    for i in CartesianIndices(size(x))
        i in seen && continue
        d = Dict{CartesianIndex{2}, NTuple{5, Int}}()
        a, s... = area_sides(x, i, d)
        union!(seen, keys(d))
        price += a * sum(s)
    end
    return price
end

end  # module
