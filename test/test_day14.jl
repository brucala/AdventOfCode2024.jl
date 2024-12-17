module test_day14

using Test
using AdventOfCode2024.Day14

nday = 14

data = parse_input(nday)

test = parse_input(
"""
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test, (11,7)) == 12
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 208437768
    @test solve2(data) == 7492
end

end  # module
