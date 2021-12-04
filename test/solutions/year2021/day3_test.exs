import Aoc

aoc_test 2021, 3 do
  @test_input [
    '00100',
    '11110',
    '10110',
    '10111',
    '10101',
    '01111',
    '00111',
    '11100',
    '10000',
    '11001',
    '00010',
    '01010',
  ]

  test "Part 1" do
    assert @mod.part1(@test_input) == 198
  end

  test "Part 2" do
    assert @mod.part2(@test_input) == 230
  end
end
