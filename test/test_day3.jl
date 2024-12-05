module test_day3

using Test
using AdventOfCode2024.Day3

nday = 3

data = parse_input(nday)

test = parse_input(
"""
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
""" |> rstrip
)
test2 = parse_input(
"""
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 161
    @test solve2(test2) == 48
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 190604937
    @test solve2(data) == 82857512
end

end  # module
