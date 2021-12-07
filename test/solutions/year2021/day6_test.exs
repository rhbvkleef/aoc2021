import Aoc

aoc_test 2021, 6 do
  test "Parse" do
    assert parsed() == Nx.tensor([0, 1, 1, 2, 1, 0, 0, 0, 0])
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 5934
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 26984457539
  end
end
