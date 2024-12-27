module test_day20

using Test
using AdventOfCode2024.Day20

nday = 20

data = parse_input(nday)

test = parse_input(
"""
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test, 10) == 10
    @test solve2(test, 70) == 41
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1497
    @test solve2(data) == 1030809
end

end  # module
