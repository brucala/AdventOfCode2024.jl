module test_day10

using Test
using AdventOfCode2024.Day10

nday = 10

data = parse_input(nday)

test = parse_input(
"""
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 36
    @test solve2(test) == 81
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 501
    @test solve2(data) == 1017
end

end  # module
