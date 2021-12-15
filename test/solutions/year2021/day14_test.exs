import Aoc

aoc_test 2021, 14 do
  test "Parse" do

  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 1588
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 2188189693529
  end
end
