module Day17
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

mutable struct Program
    A::Int
    B::Int
    C::Int
    program::Vector{Int}
    instruction_pointer::Int
    out::Vector{Int}
end
Program(a, b, c, prog) = Program(a,b,c,prog,1,[])

function parse_input(x::AbstractString)
    reg, prog = split(x, "\n\n")
    regs = Int[]
    for line in splitlines(reg)
        push!(regs, toint(line[12:end]))
    end
    prog = toint.(split(prog[9:end], ','))
    return regs, prog
end

###
### Part 1
###

@enum Opcode adv bxl bst jnz bxc out bdv cdv

halt(p::Program) = p.instruction_pointer > length(p.program)
opcode(p::Program) = Opcode(p.program[p.instruction_pointer])
operand(p::Program) = p.program[p.instruction_pointer + 1]
function combo(p::Program)
    op = operand(p)
    return op <=3 ? op : op == 4 ? p.A : op == 5 ? p.B : op == 6 ? p.C : error("operand reserved")
end

function run!(p::Program)
    while !halt(p)
        run!(p::Program, Val(opcode(p)))
        p.instruction_pointer += 2
    end
    return true
end

output(p) = join(p.out, ',')

run!(p, ::Val{adv}) = p.A ÷= 2^combo(p)
run!(p, ::Val{bdv}) = p.B = p.A ÷ 2^combo(p)
run!(p, ::Val{cdv}) = p.C = p.A ÷ 2^combo(p)
run!(p, ::Val{bxl}) = p.B ⊻= operand(p)
run!(p, ::Val{bxc}) = p.B ⊻= p.C
run!(p, ::Val{bst}) = p.B = mod(combo(p),8)
run!(p, ::Val{jnz}) = p.A == 0 || (p.instruction_pointer = operand(p) - 1)
run!(p, ::Val{out}) = push!(p.out, mod(combo(p), 8))


function solve1(x)
    p = Program(x[1]..., x[2])
    run!(p)
    return output(p)
end

###
### Part 2
###

function oct2dec(x)
    y = 0
    for (a,b) in enumerate(reverse(x))
        y += b * 8 ^ (a-1)
    end
    return y
end

function reset!(p::Program, a, b, c)
    p.A, p.B, p.C = a, b, c
    p.instruction_pointer = 1
    p.out = []
    return p
end

function solve2(x)
    a, b, c = x[1]
    prog = x[2]
    p = Program(a, b, c, prog)
    len = length(prog)
    sol = zeros(Int, len)
    sol[1] = 1
    i = 1
    while i <= len
        while sol[i] < 8
            a = oct2dec(sol)
            reset!(p, a, b, c)
            run!(p)
            p.out[len-i+1] == p.program[len-i+1] && break
            sol[i] += 1
        end
        if sol[i] < 8
            i += 1
        else
            sol[i] = 0
            while p.out[len-i+1] != p.program[len-i+1]
                i -= 1
            end
            sol[i] += 1
        end
    end
    return oct2dec(sol)
end

end  # module
