defmodule Aoc2021.Solution.Day1 do
  @behaviour Aoc2021.Solution

  @doc ~S"""
  Solution for 2021 day 1, part 1

  ## Examples

      iex> Aoc2021.Solution.Day1.part1 ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
      7
  """
  @impl Aoc2021.Solution
  def part1 lines do
    measurements = Aoc2021.integers(lines)
    count_increasing(hd(measurements), tl(measurements))
  end

  @spec count_increasing(integer, [integer], integer) :: integer
  defp count_increasing(last, list, count \\ 0)
  defp count_increasing(last, [current | rest], count) when last < current do
    count_increasing current, rest, count + 1
  end
  defp count_increasing(_, [current | rest], count) do
    count_increasing current, rest, count
  end
  defp count_increasing(_, [], count) do
    count
  end

  @doc ~S"""
  Solution for 2021 day 1, part 2

  ## Examples

      iex> Aoc2021.Solution.Day1.part2 ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
      5
  """
  @impl Aoc2021.Solution
  def part2 lines do
    measurements = Aoc2021.integers(lines)
    count_sliding(measurements)
  end

  @spec count_sliding([integer], integer) :: integer
  defp count_sliding(list, count \\ 0)
  defp count_sliding([a, b, c, d | rest], count) when (a + b + c) < (b + c + d) do
    count_sliding([b, c, d | rest], count + 1)
  end
  defp count_sliding([_a, b, c, d | rest], count) do
    count_sliding([b, c, d | rest], count)
  end
  defp count_sliding(_list, count) do
    count
  end
end
