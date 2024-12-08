module test_day6

using Test
using AdventOfCode2024.Day6

nday = 6

data = parse_input(nday)

test = parse_input(
"""
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 41
    @test solve2(test) == 6
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 5329
    @test solve2(data) == 2162
end

end  # module
