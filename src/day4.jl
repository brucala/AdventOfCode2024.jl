module Day4
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = getgrid(x)

###
### Part 1
###

function nxmas(grid, i, j)
    I, J = size(grid)
    n = 0

    i + 3 <= I && join(grid[i:i+3, j]) == "XMAS" && (n += 1)
    i > 3 && join(grid[i:-1:i-3, j]) == "XMAS" && (n += 1)
    if j + 3 <= J
        join(grid[i, j:j+3]) == "XMAS" && (n += 1)
        i + 3 <= I && join(grid[a,b] for (a,b) in zip(i:i+3, j:j+3)) == "XMAS" && (n += 1)
        i > 3 && join(grid[a,b] for (a,b) in zip(i:-1:i-3, j:j+3)) == "XMAS" && (n += 1)
    end
    if j > 3
        join(grid[i, j:-1:j-3]) == "XMAS" && (n += 1)
        i + 3 <= I && join(grid[a,b] for (a,b) in zip(i:i+3,j:-1:j-3)) == "XMAS" && (n += 1)
        i > 3 && join(grid[a,b] for (a,b) in zip(i:-1:i-3,j:-1:j-3)) == "XMAS" && (n += 1)
    end
    return n
end

function solve1(x, fun=nxmas, c='X')
    n = 0
    for pos in findall(==(c), x)
        n += fun(x, pos.I...)
    end
    return n
end

###
### Part 2
###

function ncrossmas(grid, i, j)
    I, J = size(grid)
    (1 < i < I && 1 < j < J) || return 0

    t = join([grid[i-1,j-1], grid[i-1,j+1], grid[i+1,j-1], grid[i+1,j+1]])
    t in ("MMSS", "SSMM", "MSMS", "SMSM") && return 1
    return 0
end

solve2(x) = solve1(x, ncrossmas, 'A')

end  # module
