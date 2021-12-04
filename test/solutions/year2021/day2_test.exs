import Aoc

aoc_test 2021, 2 do
  @test_input [
    {:forward, 5},
    {:down, 5},
    {:forward, 8},
    {:up, 3},
    {:down, 8},
    {:forward, 2}]

  test "Part 1" do
    assert @mod.part1(@test_input) == 150
  end

  test "Part 2" do
    assert @mod.part2(@test_input) == 900
  end
end
