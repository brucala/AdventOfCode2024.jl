module test_day9

using Test
using AdventOfCode2024.Day9

nday = 9

data = parse_input(nday)

test = parse_input(
"""
2333133121414131402
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 1928
    @test solve2(test) == 2858
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 6154342787400
    @test solve2(data) == 6183632723350
end

end  # module
