module test_day12

using Test
using AdventOfCode2024.Day12

nday = 12

data = parse_input(nday)

test = parse_input(
"""
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 1930
    @test solve2(test) == 1206
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1522850
    @test solve2(data) == 953738
end

end  # module
