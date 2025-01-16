module Day24
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    x1, x2 = split(x, "\n\n")

    inputs = Dict{String, Bool}()
    for v in splitlines(x1)
        a, b = split(v)
        inputs[a[1:end-1]] = parse(Bool, b)
    end

    instructions = Dict{String, NTuple{3,String}}()
    for ins in splitlines(x2)
        a, op, b, _, y = split(ins)
        instructions[y] = (op, a, b)
    end

    return inputs, instructions
end

###
### Part 1
###

run(ins::String, a, b) = run(Val(Symbol(ins)), a, b)
run(::Val{:AND}, a, b) = a & b
run(::Val{:OR}, a, b) = a | b
run(::Val{:XOR}, a, b) = a ⊻ b


bits(values, c) = [v for (k,v) in sort(values, rev=true) if k[1]==c]
toint(x::Union{BitArray, Vector{Bool}}) = parse(Int, join(Int.(x)), base=2)

function solve1(x)
    values, instructions = x
    values = deepcopy(values)

    q = [s for s in keys(instructions) if s[1] == 'z']

    while !isempty(q)
        length(q) > length(instructions) && return -1
        y = pop!(q)
        haskey(values, y) && continue
        ins, x1, x2 = instructions[y]
        !haskey(values, x1) && (push!(q, y, x1); continue)
        !haskey(values, x2) && (push!(q, y, x2); continue)
        values[y] = run(ins, values[x1], values[x2])
    end

    return toint(bits(values, 'z'))
    #z = sort([k=>v for (k,v) in values if k[1]=='z'], rev=true)
    #return toint([b for (_,b) in z])
    #z = sort([k=>v for (k,v) in values if k[1]=='z'])
    #return sum(b * 2 ^ (i-1) for (i, (_, b)) in enumerate(z))
end

###
### Part 2
###

# this is a 45 bit adder:
# z_i = (x_i XOR y_i) XOR c_{i-1}
# c_i = (x_i AND y_i) OR ((x_i XOR y_i) AND c_{i-1})
# c_0 = x_0 AND y_0

function solve2(x)
    _, instructions = x

    wrong = String[]
    for (k, v) in instructions
        if k[1] == 'z' # 1 all z should be an XOR operation not made of x and y
            # except z00 and z45
            if k == "z00"
                (v[1] != "XOR" || v[2][1] ∉ "xy") && push!(wrong, k)
            elseif k == "z45"
                v[1] != "OR" && push!(wrong, k)
            elseif v[1] != "XOR" || v[2][1] in "xy"
                push!(wrong, k)
            end
        elseif v[1] == "XOR" # 2 all XOR should be on xy inputs or on z outputs
            #k[1] != 'z' && v[2][1] ∉ "xy" && push!(wrong, k)
            if v[2][1] ∉ "xy"
                push!(wrong, k)
            else
                # if xor of xy then it should appear as operand twice as AND and as XOR
                count(x -> k in (x[2], x[3]), values(instructions)) != 2 && push!(wrong, k)
            end
        elseif v[1] == "AND" && v[2][1] in "xy" && v[2][2:end] != "00"
            # if and of xy then it should appear only once as operand of an OR operation (except for the first bit)
            count(x -> k in (x[2], x[3]), values(instructions)) != 1 && push!(wrong, k)
        end
    end
    return join(sort(wrong), ',')
end

#=
tobits(a::Int) = reverse(digits(Bool, a; base=2))
bitsum(a, b) = tobits(toint(a) + toint(b))

function swap(d, k1, k2)
    d = deepcopy(d)
    v1 = d[k1]
    d[k1] = d[k2]
    d[k2] = v1
    return d
end

function solve2(a)
    values, instructions = a
    x = bits(values, 'x')
    y = bits(values, 'y')
    expected = bitsum(x, y)
    #z = tobits(solve1(a))
    # findall(reverse(expected .!= z)) .- 1

    # solution found by manually inspecting the input with some hints of where to look
    # this is a 45 bit adder:
    # z_i = (x_i XOR y_i) XOR c_{i-1}
    # c_i = (x_i AND y_i) OR ((x_i XOR y_i) AND c_{i-1})
    # c_0 = x_0 AND y_0
    # I first found the bits that came up wrong, and manually checked the input to find
    # which assignments were wrong based on the formula:
    # z35 <-> jbp, z15 <-> jgc, z22 <-> drg, qjb <-> gvw

    ins = swap(instructions, "z35", "jbp")
    ins = swap(ins, "z15", "jgc")
    ins = swap(ins, "z22", "drg")
    ins = swap(ins, "qjb", "gvw")
    # these also worked for the paticular x,y input, but it isn't universal
    #ins = swap(ins, "z22", "z23")
    #ins = swap(ins, "z08", "z09")
    z = tobits(solve1((values, ins)))
    return all(expected .== z)
end
=#

end  # module
