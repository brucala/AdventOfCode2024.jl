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
    isempty(p) & isempty(x) && return r

    pivot = largest_element(collect(p ∪ x))

    largest_graph = Set{String}()
    for v in setdiff(p, g[pivot])
        pp = p ∩ g[v]
        if length(largest_graph) < length(pp) + length(r) + 1
            graph = bron_kerbosch(r ∪ Set([v]), pp, x ∩ g[v], g)
            length(graph) > length(largest_graph) && (largest_graph = graph)
        end
        pop!(p, v)
        push!(x, v)
    end

    return largest_graph
end

function solve2(x)
    g = bron_kerbosch(Set{String}(), Set(keys(x)), Set{String}(), x)
    return join(sort(collect(g)), ',')
end

end  # module
