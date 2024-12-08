module Day8
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    lines = splitlines(x)
    gsize = length(lines), length(lines[1])
    antennas = Dict{Char, Vector{Point}}()
    for (r, line) in enumerate(lines)
        for (c, freq) in enumerate(line)
            freq == '.' || push!(get!(antennas, freq, Point[]), (r,c))
        end
    end
    return antennas, gsize
end

###
### Part 1
###


inbounds(p, gsize) = all((0,0) .< p .<= gsize)

function solve1(x)
    antennas, gsize = x
    antinodes = Set{Point}()
    for freq in values(antennas)
        for a1 in 1:(length(freq)-1)
            for a2 in (a1+1):length(freq)
                anode = 2 .* freq[a1] .- freq[a2]
                inbounds(anode, gsize) && push!(antinodes, anode)
                anode = 2 .* freq[a2] .- freq[a1]
                inbounds(anode, gsize) && push!(antinodes, anode)
            end
        end
    end
    return length(antinodes)
end

###
### Part 2
###

function solve2(x)
    antennas, gsize = x
    antinodes = Set{Point}()
    for freq in values(antennas)
        for a1 in 1:(length(freq)-1)
            for a2 in (a1+1):length(freq)
                a = freq[a1]
                Δ = a .- freq[a2]
                push!(antinodes, a)
                anode = a
                while true
                    anode = anode .+ Δ
                    inbounds(anode, gsize) || break
                    push!(antinodes, anode)
                end
                anode = a
                while true
                    anode = anode .- Δ
                    inbounds(anode, gsize) || break
                    push!(antinodes, anode)
                end
            end
        end
    end
    return length(antinodes)
end

end  # module
