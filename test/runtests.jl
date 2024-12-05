using Test
using AdventOfCode2024

@testset "AdventOfCode2024 tests" begin
     for day in solved_days
        @testset "Day $day" begin include("test_day$day.jl") end
     end
end
