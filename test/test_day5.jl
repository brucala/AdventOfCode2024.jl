module test_day5

using Test
using AdventOfCode2024.Day5

nday = 5

data = parse_input(nday)

test = parse_input(
"""
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 143
    @test solve2(test) == 123
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 5268
    @test solve2(data) == 5799
end

end  # module
