module test_day4

using Test
using AdventOfCode2024.Day4

nday = 4

data = parse_input(nday)

test = parse_input(
"""
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 18
    @test solve2(test) == 9
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2560
    @test solve2(data) == 1910
end

end  # module
