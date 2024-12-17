module test_day13

using Test
using AdventOfCode2024.Day13

nday = 13

data = parse_input(nday)

test = parse_input(
"""
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 480
    @test solve2(test) == 875318608908
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 27157
    @test solve2(data) == 104015411578548
end

end  # module
