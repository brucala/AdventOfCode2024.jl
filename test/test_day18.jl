module test_day18

using Test
using AdventOfCode2024.Day18

nday = 18

data = parse_input(nday)

test = parse_input(
"""
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test, 12, 6) == 22
    @test solve2(test, 6) == (6,1)
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 272
    @test solve2(data) == (16,44)
end

end  # module
