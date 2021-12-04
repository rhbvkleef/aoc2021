defmodule Aoc2021.Solution.Day3 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  defdelegate parse(input), to: Aoc2021, as: :chars2d

  @impl Aoc2021.Solution
  def part1 input do
    total = length(input)

    one_counts = input
      |> Enum.reduce(List.duplicate(0, length(hd(input))), fn elem, acc ->
        Enum.zip(elem, acc)
          |> Enum.map(fn
            {?1, a} -> a + 1
            {_, a} -> a end)
      end)

    most = one_counts
      |> Enum.map(fn
        ones when (total / 2) > ones -> ?0
        _ -> ?1
      end)
      |> :erlang.list_to_integer(2)

    mask = Enum.reduce(one_counts, 1, fn _, acc -> Bitwise.<<<(acc, 1) end) - 1

    most * Bitwise.&&&(Bitwise.bnot(most), mask)
  end

  @impl Aoc2021.Solution
  def part2 input do
    oxy = part2_reduce(input, &(&1 > &2))
    co2 = part2_reduce(input, &(&1 <= &2))

    :erlang.list_to_integer(oxy, 2) * :erlang.list_to_integer(co2, 2)
  end

  defp part2_reduce(lines, comparator, acc \\ [])
  defp part2_reduce([line], _, acc), do: Enum.reverse(acc) ++ line
  defp part2_reduce(lines, comparator, acc) do
    {zeros, ones} = lines
      |> Enum.reduce({0, 0},
          fn [?0 | _], {zeros, ones} -> {zeros + 1, ones}
             _,        {zeros, ones} -> {zeros, ones + 1} end)

    by = if apply(comparator, [zeros, ones]) do ?0 else ?1 end
    result = lines
      |> Enum.filter(&(hd(&1) == by))
      |> Enum.map(&tl/1)

    part2_reduce result, comparator, [by | acc]
  end
end
