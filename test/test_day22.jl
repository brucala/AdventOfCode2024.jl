module test_day22

using Test
using AdventOfCode2024.Day22

nday = 22

data = parse_input(nday)

test = parse_input(
"""
1
10
100
2024
""" |> rstrip
)

test2 = parse_input(
"""
1
2
3
2024
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 37327623
    @test solve2(test2) == 23
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 16953639210
    @test solve2(data) == 1863
end

end  # module
