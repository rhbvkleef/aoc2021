import Aoc

aoc 2021, 5 do
  @impl Aoc.Solution
  def parse(text) do
    String.split(text, [" -> ", ",", "\n"], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(4, 4, :discard)
  end

  @impl Aoc.Solution
  def part1(input) do
    with_ets fn ets ->
      Enum.filter(input, fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
        |> Enum.each(&plot(&1, ets))

      :ets.select_count(ets, [{{:_, :"$2"}, [{:>, :"$2", 1}], [true]}])
    end
  end

  @impl Aoc.Solution
  def part2(input) do
    with_ets fn ets ->
      Enum.each(input, &plot(&1, ets))

      :ets.select_count(ets, [{{:_, :"$2"}, [{:>, :"$2", 1}], [true]}])
    end
  end

  defp with_ets fun do
    ets = :ets.new(:temp, [:set])
    try do
      fun.(ets)
    after
      :ets.delete(ets)
    end
  end

  defp plot [x, from1y, x, to1y], ets do
    Enum.each(from1y..to1y, &:ets.update_counter(ets, {x, &1}, {2, 1}, {nil, 0}))
  end
  defp plot [from1x, y, to1x, y], ets do
    Enum.each(from1x..to1x, &:ets.update_counter(ets, {&1, y}, {2, 1}, {nil, 0}))
  end
  defp plot([from1x, from1y, to1x, to1y], ets) do
    Enum.zip(from1x..to1x, from1y..to1y)
      |> Enum.each(&:ets.update_counter(ets, &1, {2, 1}, {nil, 0}))
  end
end
