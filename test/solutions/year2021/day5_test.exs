import Aoc

aoc_test 2021, 5 do
  test "Parse" do
    assert parsed() == [
      [0, 9, 5, 9],
      [8, 0, 0, 8],
      [9, 4, 3, 4],
      [2, 2, 2, 1],
      [7, 0, 7, 4],
      [6, 4, 2, 0],
      [0, 9, 2, 9],
      [3, 4, 1, 4],
      [0, 0, 8, 8],
      [5, 5, 8, 2]
    ]
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 5
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 12
  end
end
