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
    lines
      |> Aoc2021.integers
      |> count_increasing
  end

  @spec count_increasing([integer], integer) :: integer
  defp count_increasing(list, count \\ 0)
  defp count_increasing([a, b | rest], count) when a < b do
    count_increasing [b | rest], count + 1
  end
  defp count_increasing([_a | rest], count) do
    count_increasing rest, count
  end
  defp count_increasing([], count), do: count

  @doc ~S"""
  Solution for 2021 day 1, part 2

  ## Examples

      iex> Aoc2021.Solution.Day1.part2 ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
      5
  """
  @impl Aoc2021.Solution
  def part2 lines do
    lines
      |> Aoc2021.integers
      |> count_sliding
  end

  @spec count_sliding([integer], integer) :: integer
  defp count_sliding(list, count \\ 0)
  defp count_sliding([a, b, c, d | rest], count) when (a + b + c) < (b + c + d) do
    count_sliding [b, c, d | rest], count + 1
  end
  defp count_sliding([_a | rest], count) do
    count_sliding rest, count
  end
  defp count_sliding(_list, count), do: count
end
