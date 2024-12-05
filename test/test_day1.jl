module test_day1

using Test
using AdventOfCode2024.Day1

nday = 1

data = parse_input(nday)

test = parse_input(
"""
3   4
4   3
2   5
1   3
3   9
3   3
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 11
    @test solve2(test) == 31
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2264607
    @test solve2(data) == 19457120
end

end  # module
