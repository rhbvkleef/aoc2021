defmodule Aoc2021.Solution.Day1 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  @spec parse(binary) :: [integer]
  def parse(text), do: Aoc2021.integers1d(text)

  @impl Aoc2021.Solution
  @spec part1([integer], non_neg_integer) :: non_neg_integer
  def part1(list, count \\ 0)
  def part1([a, b | rest], count) when a < b do
    part1 [b | rest], count + 1
  end
  def part1([_a | rest], count) do
    part1 rest, count
  end
  def part1([], count), do: count

  @impl Aoc2021.Solution
  @spec part2([integer], non_neg_integer) :: non_neg_integer
  def part2(list, count \\ 0)
  def part2([a, b, c, d | rest], count) when (a + b + c) < (b + c + d) do
    part2 [b, c, d | rest], count + 1
  end
  def part2([_a | rest], count) do
    part2 rest, count
  end
  def part2(_list, count), do: count
end
