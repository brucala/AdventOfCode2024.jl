module Day5
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    x1, x2 = split(x, "\n\n")
    rules = Dict{Int, Vector{Int}}()
    for line in splitlines(x1)
        l,r = toint.(split(line, '|'))
        push!(get!(rules, l, Int[]), r)
        #rules[l] = r
    end
    pages = Vector{Vector{Int}}()
    for line in splitlines(x2)
        push!(pages, toint.(split(line, ',')))
    end
    return rules, pages
end

###
### Part 1
###

getscore(x) = x[(length(x)+1) ÷ 2]
function isordered(dpage, rules)
    is_ordered = true
    for k in keys(dpage)
        haskey(rules, k) || continue
        for v in rules[k]
            haskey(dpage, v) || continue
            dpage[k] < dpage[v] && continue
            is_ordered = false
            break
        end
        is_ordered || break
    end
    return is_ordered
end

function solve1(x)
    rules, pages = x
    score = 0
    for page in pages
        dpage = Dict(v => i for (i,v) in enumerate(page))
        isordered(dpage, rules) && (score += getscore(page))
    end
    return score
end

###
### Part 2
###


function order(page, rules)
    spage = Set(page)
    opage = Int[]
    for (k,vv) in rules
        k in spage || continue
        k ∉ opage && pushfirst!(opage, k)
        for v in vv
            v in spage || continue
            if v ∉ opage
                push!(opage, v)
                continue
            end
            ik, iv = indexin([k,v], opage)
            ik < iv && continue
            opage = [opage[1:iv-1]; k; opage[iv:ik-1]; opage[ik+1:end]]
        end
    end
    return opage
end

function solve2(x)
    rules, pages = x
    score = 0
    for page in pages
        dpage = Dict(v => i for (i,v) in enumerate(page))
        isordered(dpage, rules) && continue
        score += getscore(order(page, rules))
    end
    return score

end

end  # module
