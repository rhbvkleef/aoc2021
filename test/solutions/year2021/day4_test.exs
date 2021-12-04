import Aoc

aoc_test 2021, 4 do
  test "parse" do
    assert elem(parsed(), 0) == Enum.map([
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
    ], &Integer.to_string/1)

    assert length(elem(parsed(), 1)) == 3
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 4512
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 1924
  end
end
