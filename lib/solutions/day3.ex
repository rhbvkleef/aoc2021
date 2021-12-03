defmodule Aoc2021.Solution.Day3 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  @spec parse(binary) :: [[char]]
  @doc "Parse the input as a 1d list of charlists"
  defdelegate parse(input), to: Aoc2021, as: :chars2d

  @impl Aoc2021.Solution
  def part1 input do
    total = length(input)

    one_counts = input
      |> transpose
      |> Enum.map(fn bit -> Enum.count(bit, fn elem -> elem == ?1 end) end)

    most = one_counts
      |> Enum.map(fn
        ones when (total / 2) > ones -> ?0
        _ -> ?1
      end)
      |> :erlang.list_to_integer(2)

    least = one_counts
      |> Enum.map(fn
        ones when (total / 2) > ones -> ?1
        _ -> ?0
      end)
      |> :erlang.list_to_integer(2)

    most * least
  end

  defp transpose([[] | _]), do: []
  defp transpose(list), do: [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]

  @impl Aoc2021.Solution
  def part2 input do
    entries = input |> Enum.map(fn cur -> {cur, cur} end)

    {oxy, _} = part2_reduce(entries, fn (a, b) -> if a <= b do ?1 else ?0 end end)
    {co2, _} = part2_reduce(entries, fn (a, b) -> if a <= b do ?0 else ?1 end end)

    :erlang.list_to_integer(oxy, 2) * :erlang.list_to_integer(co2, 2)
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

  defp count_column pairs do
    Enum.reduce(
      pairs,
      {0, 0},
      fn {_, [chr | _]}, {zeros, ones} ->
        if chr == ?0 do {zeros + 1, ones}
        else {zeros, ones + 1} end
      end)
  end
end
