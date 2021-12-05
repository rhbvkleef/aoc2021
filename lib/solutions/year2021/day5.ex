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
    Enum.filter(input, fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
      |> Enum.reduce(%{}, &plot/2)
      |> Enum.count(fn {_, c} -> c >= 2 end)
  end

  @impl Aoc.Solution
  def part2(input) do
    Enum.reduce(input, %{}, &plot/2)
      |> Enum.count(fn {_, c} -> c >= 2 end)
  end

  defp plot [x, from1y, x, to1y], map do
    Enum.reduce(from1y..to1y, map, fn y, acc -> Map.update(acc, {x, y}, 1, &(&1 + 1)) end)
  end
  defp plot [from1x, y, to1x, y], map do
    Enum.reduce(from1x..to1x, map, fn x, acc -> Map.update(acc, {x, y}, 1, &(&1 + 1)) end)
  end
  defp plot([from1x, from1y, to1x, to1y], map) when from1x - to1x == from1y - to1y do
    min_x = min(from1x, to1x)
    min_y = min(from1y, to1y)

    Enum.reduce(0..abs(from1x - to1x), map, fn delta, acc ->
      Map.update(acc, {min_x + delta, min_y + delta}, 1, &(&1 + 1))
    end)
  end
  defp plot([from1x, from1y, to1x, to1y], map) when from1x - to1x == to1y - from1y do
    min_x = min(from1x, to1x)
    max_y = max(from1y, to1y)

    Enum.reduce(0..abs(from1x - to1x), map, fn delta, acc ->
      Map.update(acc, {min_x + delta, max_y - delta}, 1, &(&1 + 1))
    end)
  end
end
