module test_day11

using Test
using AdventOfCode2024.Day11

nday = 11

data = parse_input(nday)

test = parse_input("125 17")

@testset "Day$nday tests" begin
    @test solve1(test) == 55312
    @test solve2(test) == 65601038650482
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 217812
    @test solve2(data) == 259112729857522
end

end  # module
