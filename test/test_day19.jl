module test_day19

using Test
using AdventOfCode2024.Day19

nday = 19

data = parse_input(nday)

test = parse_input(
"""
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 6
    @test solve2(test) == 16
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 280
    @test solve2(data) == 606411968721181
end

end  # module
