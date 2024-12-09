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
    next::Union{Block, Nothing}
    prev::Union{Block,Nothing}
end
Block(start, len, id) = Block(start, len, id, nothing, nothing)

Base.show(io::IO, b::Block) = print(io, (b.start, b.len, b.id))
function Base.length(b::Block)
    len = 0
    while !isnothing(b)
        len += 1
        b = b.next
    end
    return len
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

    firstblock = Block(0, x[1], 0)
    bprev = firstblock
    for (i,len) in enumerate(x[2:end])
        len == 0 && continue
        start = bprev.start + bprev.len
        b =  Block(start, len, iseven(i) ? i ÷ 2 : -1)
        bprev.next = b
        b.prev = bprev
        bprev = b
    end

    b2 = bprev
    b = firstblock.next
    while !isnothing(b2)
        if b2.id < 0
            b2 = b2.prev
            continue
        end

        while b.id >= 0
            b = b.next
        end

        b1 = b
        while b1.start < b2.start
            if b1.id > 0 || b1.len < b2.len
                b1 = b1.next
                continue
            end
            break
        end
        if b1.start >= b2.start
            b2 = b2.prev
            continue
        end

        b1.id = b2.id
        b2.id = -1

        if b2.len != b1.len
            bb = Block(b1.start + b2.len, b1.len - b2.len, -1, b1.next, b1)
            b1.next = bb
            b1.len = b2.len
        end
        b2 = b2.prev
    end
    return firstblock
end

function checksum2(b::Block)
    s = 0
    while !isnothing(b)
        s += b.id <= 0 ? 0 : (b.len) * (2* b.start + b.len - 1) ÷ 2 * b.id
        b = b.next
    end
    return s
end

solve2(x) = checksum2(read_disk2(x))

end  # module
