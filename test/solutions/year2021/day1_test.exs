import Aoc

aoc_test 2021, 1 do
  @testinput [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

  test "Part 1" do
    assert mod().part1(@testinput) == 7
  end

  test "Part 2" do
    assert mod().part2(@testinput) == 5
  end
end
