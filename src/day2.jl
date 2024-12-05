module Day2
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = [toint.(split(line)) for line in splitlines(x)]

###
### Part 1
###

issafe(d) = all(x -> 0 < abs(x) < 4, d) && allequal(sign, d)

function solve1(reports)
    nsafe = 0
    for report in reports
        issafe(diff(report)) || continue
        nsafe += 1
    end
    return nsafe
end

###
### Part 2
###

function solve2(reports)
    nsafe = 0
    for report in reports
        safe = true
        if !issafe(diff(report))
            safe = false
            for i in 1:length(report)
                if issafe(diff([report[1:i-1]; report[i+1:end]]))
                    safe = true
                    break
                end
            end
        end
        safe || continue
        nsafe += 1
    end
    return nsafe
end

end  # module
