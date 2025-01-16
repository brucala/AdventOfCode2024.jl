module Day21
include("utils.jl")
using .Utils
import .Utils: parse_input

import DataStructures: BinaryMinHeap

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = splitlines(x)

###
### Part 1
###

const NUMPAD = ['7' '8' '9'; '4' '5' '6'; '1' '2' '3'; ' ' '0' 'A']
const DIRPAD = [' ' '^' 'A'; '<' 'v' '>']

const DIR = Dict('^' => (-1, 0),'<' => (0, -1), 'v' => (1, 0),'>' => (0, 1))

abstract type PadType end
abstract type NumPad <: PadType end
abstract type DirPad <: PadType end

mutable struct Pad{T<:PadType}
    pos::Point
end
Pad{T}() where T = Pad{T}(findfirst(==('A'), pad(T)).I)
NumPad() = Pad{NumPad}()
DirPad() = Pad{DirPad}()
NumPad(c::Char) = Pad{NumPad}(findfirst(==(c), pad(NumPad)).I)
DirPad(c::Char) = Pad{DirPad}(findfirst(==(c), pad(DirPad)).I)

pad(::Type{NumPad}) = NUMPAD
pad(::Type{DirPad}) = DIRPAD
pad(::Pad{T}) where T = pad(T)

Base.isless(p1::Pad, p2::Pad) = p1.pos < p2.pos

Base.show(io::IO, p::Pad)= print(io, pad(p)[p.pos...])

pos(pads::Vector{Pad}) = Tuple([p.pos for p in pads])

function paths(p::Pad{T}, c::Char) where T
    p1, p2 = p.pos, findfirst(==(c), pad(p)).I
    v, h = p2 .- p1
    vmoves = fill(v > 0 ? 'v' : '^', abs(v))
    hmoves = fill(h > 0 ? '>' : '<', abs(h))

    if p1[1] == 1 && p2[2] == 1 && T == DirPad
        return Set([join([vmoves; hmoves])])
    elseif p1[2] == 1 && p2[1] == 1 && T == DirPad
        return Set([join([hmoves; vmoves])])
    elseif p1[2] == 1 && p2[1] == 4 && T == NumPad
        return Set([join([hmoves; vmoves])])
    elseif p1[1] == 4 && p2[2] == 1 && T == NumPad
        return Set([join([vmoves; hmoves])])
    end

    return Set([join([hmoves; vmoves]), join([vmoves; hmoves])])
end

function nmoves(pad::Pad, c::Char, npads, D)
    k = pad.pos, c, npads
    haskey(D, k) && return D[k]
    n = minimum(nmoves(DirPad(), path * 'A', npads - 1, D) for path in paths(pad, c))
    D[k] = n
    return n
end

function nmoves(pad::Pad, code::AbstractString, npads, D)
    npads == 0 && return length(code)

    n  = 0
    for c in code
        n += nmoves(pad, c, npads, D)
        to!(pad, c)
    end
    return n
end

function to!(p::Pad, c::Char)
    p.pos = findfirst(==(c), pad(p)).I
end

function solve1(x, npads=2)
    D = Dict{Tuple{Point, Char, Int}, Int}()
    sol = 0
    for code in x
        sol += toint(code[1:end-1]) * nmoves(NumPad(), code, npads+1, D)
    end
    return sol
end

###
### Part 2
###

solve2(x) = solve1(x, 25)

end  # module
