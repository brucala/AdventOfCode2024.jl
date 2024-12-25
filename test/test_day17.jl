module test_day17

using Test
using AdventOfCode2024.Day17

nday = 17

data = parse_input(nday)

test = parse_input(
"""
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
""" |> rstrip
)

test2 = parse_input(
"""
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == "4,6,3,5,6,3,5,2,1,0"
    @test solve2(test2) == 117440
end

@testset "Day$nday solutions" begin
    @test solve1(data) == "2,3,6,2,1,6,1,2,1"
    @test solve2(data) == 90938893795561
end

end  # module
