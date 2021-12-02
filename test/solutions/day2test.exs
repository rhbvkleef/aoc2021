defmodule Aoc2021.Solution.Day2test do
  use ExUnit.Case, async: true
  doctest Aoc2021.Solution.Day2

  @test_input [
    {:forward, 5},
    {:down, 5},
    {:forward, 8},
    {:up, 3},
    {:down, 8},
    {:forward, 2}]

  test "Part 1" do
    assert Aoc2021.Solution.Day2.part1(@test_input) == 150
  end

  test "Part 2" do
    assert Aoc2021.Solution.Day2.part2(@test_input) == 900
  end
end
