module test_day25

using Test
using AdventOfCode2024.Day25

nday = 25

data = parse_input(nday)

test = parse_input(
"""
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 3
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 3223
end

end  # module
