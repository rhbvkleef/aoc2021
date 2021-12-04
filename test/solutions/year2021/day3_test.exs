import Aoc

aoc_test 2021, 3 do
  test "Part 1" do
    assert @mod.part1(parsed()) == 198
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 230
  end
end
