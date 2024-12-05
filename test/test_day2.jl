module test_day2

using Test
using AdventOfCode2024.Day2

nday = 2

data = parse_input(nday)

test = parse_input(
"""
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 2
    @test solve2(test) == 4
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 279
    @test solve2(data) == 343
end

end  # module
