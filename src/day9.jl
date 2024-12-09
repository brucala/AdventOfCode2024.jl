module Day9
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = toint.(collect(x))

###
### Part 1
###

mutable struct Block
    start::Int
    len::Int
    id::Int
end

function read_disk(x::Vector{Int})
    x = copy(x)
    disk = Block[]
    start = 0
    for i in 1:length(x)
        i > length(x) && break
        len = x[i]
        len == 0 && continue
        if isodd(i)
            push!(disk, Block(start, len, (i - 1) ÷ 2))
            start += len
            continue
        end
        # if empty
        while len > 0
            length(x) > i || break
            len2, id = x[end], (length(x) - 1) ÷ 2
            if len >= len2
                push!(disk, Block(start, len2, id))
                start += len2
                len -= len2
                pop!(x)
                pop!(x)
            else
                x[end] = len2 - len
                push!(disk, Block(start, len, id))
                start += len
                len = 0
            end
        end
    end
    return disk
end

checksum(b::Block) = b.id <= 0 ? 0 : (b.len) * (2* b.start + b.len - 1) ÷ 2 * b.id
checksum(x::Vector{Block}) = sum(checksum, x)

solve1(x) = checksum(read_disk(x))

###
### Part 2
###

function read_disk2(x::Vector{Int})

    disk = Block[]
    start = 0
    for (i,len) in enumerate(x)
        push!(disk, Block(start, len, isodd(i) ? (i-1) ÷ 2 : -1))
        start += len
    end

    j = length(disk)
    while j > 0
        b2 = disk[j]
        if b2.id < 0
            j -= 1
            continue
        end

        i = 2
        while i < j
            b = disk[i]
            if b.id > 0 || b.len < b2.len
                i += 1
                continue
            end
            break
        end
        if i >= j
            j -= 1
            continue
        end

        b = disk[i]
        b.id = b2.id
        b2.id = -1

        if b2.len == b.len
            j -= 1
        else
            bb = Block(b.start + b2.len, b.len - b2.len, -1)
            b.len = b2.len
            disk = [disk[1:i]; bb; disk[i+1:end]]
        end
    end
    return disk
end

solve2(x) = checksum(read_disk2(x))

end  # module
