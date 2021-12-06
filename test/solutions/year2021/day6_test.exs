import Aoc

aoc_test 2021, 6 do
  test "Parse" do
    assert parsed() == [3, 4, 3, 1, 2]
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 5934
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 26984457539
  end
end
