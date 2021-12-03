defmodule Aoc2021.Solution.Day3 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  @spec parse(binary) :: [[char]]
  @doc "Parse the input as a 1d list of charlists"
  defdelegate parse(input), to: Aoc2021, as: :chars2d

  @impl Aoc2021.Solution
  def part1 input do
    counts = input
      |> Enum.map(fn line -> {line, line} end)
      |> part1_count

    most = counts
      |> Enum.map(fn {zeros, ones} -> if zeros > ones do ?0 else ?1 end end)
      |> to_string
      |> String.to_integer(2)

    least = counts
      |> Enum.map(fn {zeros, ones} -> if zeros > ones do ?1 else ?0 end end)
      |> to_string
      |> String.to_integer(2)

    most * least
  end

  defp count_column pairs do
    Enum.reduce(
      pairs,
      {0, 0},
      fn {_, [chr | _]}, {zeros, ones} ->
        if chr == ?0 do {zeros + 1, ones}
        else {zeros, ones + 1} end
      end)
  end

  defp part1_count [{_, []} | _] do
    []
  end
  defp part1_count lines do
    new_lines = lines
      |> Enum.map(fn {txt, [_ | rest]} -> {txt, rest} end)

    [count_column(lines) | part1_count(new_lines)]
  end

  @impl Aoc2021.Solution
  def part2 input do
    entries = input |> Enum.map(fn cur -> {cur, cur} end)

    {oxy, _} = part2_reduce(entries, fn (a, b) -> if a <= b do ?1 else ?0 end end)
    {co2, _} = part2_reduce(entries, fn (a, b) -> if a <= b do ?0 else ?1 end end)

    String.to_integer(to_string(oxy), 2) * String.to_integer(to_string(co2), 2)
  end

  defp part2_reduce [result], _ do
    result
  end
  defp part2_reduce input, comparator do
    {zeros, ones} = count_column(input)

    by = apply(comparator, [zeros, ones])
    result = input
      |> Enum.filter(fn {_, [ih | _]} -> ih == by end)
      |> Enum.map(fn {actual, [_ | rest]} -> {actual, rest} end)

    part2_reduce  result, comparator
  end
end
