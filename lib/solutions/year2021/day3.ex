import Aoc

aoc 2021, 3 do
  use Bitwise, only_operators: true

  @impl Aoc.Solution
  defdelegate parse(input), to: Aoc, as: :chars2d

  @impl Aoc.Solution
  def part1 input do
    total = length(input)

    most = input
      |> Enum.reduce(List.duplicate(0, length(hd(input))), fn elem, acc ->
          Enum.zip(elem, acc)
            |> Enum.map(fn
              {?1, a} -> a + 1
              {_, a} -> a end)
        end)
      |> Enum.map(fn
          ones when (total / 2) > ones -> ?0
          _ -> ?1
        end)
      |> List.to_integer(2)

    mask = (1 <<< length(hd(input))) - 1
    least = ~~~most &&& mask

    most * least
  end

  @impl Aoc.Solution
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

    by = if apply(comparator, [zeros, ones]), do: ?0, else: ?1
    result = lines
      |> Enum.filter(&(hd(&1) == by))
      |> Enum.map(&tl/1)

    part2_reduce result, comparator, [by | acc]
  end
end
