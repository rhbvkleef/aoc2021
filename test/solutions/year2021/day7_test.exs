import Aoc

aoc_test 2021, 7 do
  test "Parse" do
    assert parsed() == [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 37
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 168
  end
end
