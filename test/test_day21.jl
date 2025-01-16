module test_day21

using Test
using AdventOfCode2024.Day21

nday = 21

data = parse_input(nday)

test = parse_input(
"""
029A
980A
179A
456A
379A
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 126384
    @test solve1(test, 3) == 310188
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 176650
    @test solve2(data) == 217698355426872
end

end  # module
