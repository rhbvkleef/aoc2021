import Aoc

aoc_test 2021, 2 do
  test "Part 1" do
    assert @mod.part1(parsed()) == 150
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 900
  end
end
