module test_day8

using Test
using AdventOfCode2024.Day8

nday = 8

data = parse_input(nday)

test = parse_input(
"""
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 14
    @test solve2(test) == 34
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 379
    @test solve2(data) == 1339
end

end  # module
