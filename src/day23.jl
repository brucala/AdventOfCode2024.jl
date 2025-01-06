module Day23
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    d = Dict{String, Set{String}}()
    for line in splitlines(x)
        a, b = split(line,'-')
        push!(get!(d, a, Set()), b)
        push!(get!(d, b, Set()), a)
    end
    return d
end

###
### Part 1
###

function solve1(x)
    x = deepcopy(x)
    n = 0
    for (k1, v) in x
        startswith(k1, 't') || continue
        while !isempty(v)
            k2 = pop!(v)
            pop!(x[k2], k1)
            n += length(v ∩ x[k2])
        end
    end
    return n
end

###
### Part 2
###

largest_element(x) = x[findmax(length, x)[2]]

function bron_kerbosch(r, p, x, g)
    isempty(p) & isempty(x) && return [r]

    pivot = largest_element(collect(p ∪ x))

    graphs = Set{String}[]
    for v in setdiff(p, g[pivot])
        append!(
            graphs,
            bron_kerbosch(r ∪ Set([v]), p ∩ g[v], x ∩ g[v], g)
        )
        pop!(p, v)
        push!(x, v)
    end

    return graphs
end

function largest_connection(g)
    graphs = bron_kerbosch(Set{String}(), Set(keys(g)), Set{String}(), g)
    return largest_element(graphs)
end

solve2(x) = join(sort(collect(largest_connection(x))), ',')

end  # module
