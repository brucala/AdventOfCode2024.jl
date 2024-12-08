module test_day7

using Test
using AdventOfCode2024.Day7

nday = 7

data = parse_input(nday)

test = parse_input(
"""
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 3749
    @test solve2(test) == 11387
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 5702958180383
    @test solve2(data) == 92612386119138
end

end  # module
