defmodule Aoc2021.Solution.Day1 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  @spec parse(binary) :: [integer]
  def parse(text), do: Aoc2021.integers1d(text)

  @impl Aoc2021.Solution
  @spec part1([integer]) :: non_neg_integer
  def part1(integers), do: count_increasing(integers)

  @spec count_increasing([integer], non_neg_integer) :: non_neg_integer
  defp count_increasing(list, count \\ 0)
  defp count_increasing([a, b | rest], count) when a < b do
    count_increasing [b | rest], count + 1
  end
  defp count_increasing([_a | rest], count) do
    count_increasing rest, count
  end
  defp count_increasing([], count), do: count

  @impl Aoc2021.Solution
  @spec part2([integer]) :: non_neg_integer
  def part2(integers), do: count_sliding(integers)

  @spec count_sliding([integer], non_neg_integer) :: non_neg_integer
  defp count_sliding(list, count \\ 0)
  defp count_sliding([a, b, c, d | rest], count) when (a + b + c) < (b + c + d) do
    count_sliding [b, c, d | rest], count + 1
  end
  defp count_sliding([_a | rest], count) do
    count_sliding rest, count
  end
  defp count_sliding(_list, count), do: count
end
