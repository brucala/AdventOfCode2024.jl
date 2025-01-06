module test_day23

using Test
using AdventOfCode2024.Day23

nday = 23

data = parse_input(nday)

test = parse_input(
"""
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 7
    @test solve2(test) == "co,de,ka,ta"
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1327
    @test solve2(data) == "df,kg,la,mp,pb,qh,sk,th,vn,ww,xp,yp,zk"
end

end  # module
