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
    ets = :ets.new(:state_store, [:set, write_concurrency: true, read_concurrency: true])

    Enum.filter(input, fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
      |> Enum.each(&plot(&1, ets))

    count = :ets.select_count(ets, [{{:"$1", :"$2"}, [{:>, :"$2", 1}], [true]}])

    :ets.delete(ets)

    count
  end

  @impl Aoc.Solution
  def part2(input) do
    ets = :ets.new(:state_store, [:set, write_concurrency: true, read_concurrency: true])

    Enum.each(input, &plot(&1, ets))

    count = :ets.select_count(ets, [{{:"$1", :"$2"}, [{:>, :"$2", 1}], [true]}])

    :ets.delete(ets)

    count
  end

  defp plot [x, from1y, x, to1y], map do
    Enum.each(from1y..to1y, fn y ->
      :ets.update_counter(map, {x, y}, {2, 1}, {nil, 0})
    end)
  end
  defp plot [from1x, y, to1x, y], map do
    Enum.each(from1x..to1x, fn x ->
      :ets.update_counter(map, {x, y}, {2, 1}, {nil, 0})
    end)
  end
  defp plot([from1x, from1y, to1x, to1y], map) when from1x - to1x == from1y - to1y do
    min_x = min(from1x, to1x)
    min_y = min(from1y, to1y)

    Enum.each(0..abs(from1x - to1x), fn delta ->
      :ets.update_counter(map, {min_x + delta, min_y + delta}, {2, 1}, {nil, 0})
    end)
  end
  defp plot([from1x, from1y, to1x, to1y], map) when from1x - to1x == to1y - from1y do
    min_x = min(from1x, to1x)
    max_y = max(from1y, to1y)

    Enum.each(0..abs(from1x - to1x), fn delta ->
      :ets.update_counter(map, {min_x + delta, max_y - delta}, {2, 1}, {nil, 0})
    end)
  end
end
