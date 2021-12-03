defmodule Aoc2021.Solution.Day3 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  @spec parse(binary) :: [binary]
  @doc "Parse the input as a 1d string array."
  defdelegate parse(input), to: Aoc2021, as: :strings1d

  @impl Aoc2021.Solution
  def part1 input do
    result = part1reduce input, List.duplicate({0, 0}, String.length(hd(input)))

    most = result
      |> Enum.map(fn {zeros, ones} -> if zeros > ones do ?0 else ?1 end end)
      |> to_string
      |> String.to_integer(2)

    least = result
      |> Enum.map(fn {zeros, ones} -> if zeros > ones do ?1 else ?0 end end)
      |> to_string
      |> String.to_integer(2)

    most * least
  end

  defp part1reduce [line|lines], counts do
    new_counts = part1reduceline(String.to_charlist(line), counts)
    part1reduce lines, new_counts
  end
  defp part1reduce [], counts do
    counts
  end

  defp part1reduceline [?0|chars], [{zeros, ones}|counts] do
    [{zeros + 1, ones} | part1reduceline(chars, counts)]
  end
  defp part1reduceline [?1|chars], [{zeros, ones}|counts] do
    [{zeros, ones + 1} | part1reduceline(chars, counts)]
  end
  defp part1reduceline [], [] do
    []
  end

  @impl Aoc2021.Solution
  def part2 input do
    entries = input |> Enum.map(fn cur -> {cur, String.to_charlist(cur)} end)

    {oxy, _} = part2do(entries, fn (a, b) -> if a <= b do ?1 else ?0 end end)
    {co2, _} = part2do(entries, fn (a, b) -> if a <= b do ?0 else ?1 end end)

    String.to_integer(oxy, 2) * String.to_integer(co2, 2)
  end

  defp part2do input, comparator do
    {zeros, ones} = input
      |> Enum.reduce({0, 0}, fn {_, [chr | _]}, {zeros, ones} -> if chr == ?0 do {zeros + 1, ones} else {zeros, ones + 1} end end)

    by = apply(comparator, [zeros, ones])
    result = input
      |> Enum.filter(fn {_, [ih | _]} -> ih == by end)
      |> Enum.map(fn {actual, [_ | rest]} -> {actual, rest} end)

    if length(result) == 1 do
      hd(result)
    else
      part2do result, comparator
    end
  end
end
