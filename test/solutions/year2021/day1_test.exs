import Aoc

aoc_test 2021, 1 do
  test "Part 1" do
    assert @mod.part1(parsed()) == 7
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 5
  end
end
