defmodule Aoc2021.Solution.Day1test do
  use ExUnit.Case, async: true
  doctest Aoc2021.Solution.Day2

  @testinput [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

  test "Part 1" do
    assert Aoc2021.Solution.Day1.part1(@testinput) == 7
  end

  test "Part 2" do
    assert Aoc2021.Solution.Day1.part2(@testinput) == 5
  end
end
