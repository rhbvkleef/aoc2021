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
      |> Enum.flat_map(&pairs/1)
      |> Enum.frequencies()
      |> Enum.filter(fn {_, amount} -> amount >= 2  end)
      |> Enum.count
  end

  @impl Aoc.Solution
  def part2(input) do
    Enum.flat_map(input, &pairs/1)
      |> Enum.frequencies()
      |> Enum.filter(fn {_, amount} -> amount >= 2  end)
      |> Enum.count
  end

  defp pairs [x, from1y, x, to1y] do
    Enum.map(from1y..to1y, fn y -> {x, y} end)
  end
  defp pairs [from1x, y, to1x, y] do
    Enum.map(from1x..to1x, fn x -> {x, y} end)
  end
  defp pairs([from1x, from1y, to1x, to1y]) when from1x - to1x == from1y - to1y do
    min_x = min(from1x, to1x)
    min_y = min(from1y, to1y)

    Enum.map(0..abs(from1x - to1x), fn delta -> {min_x + delta, min_y + delta} end)
  end
  defp pairs([from1x, from1y, to1x, to1y]) when from1x - to1x == to1y - from1y do
    min_x = min(from1x, to1x)
    max_y = max(from1y, to1y)

    Enum.map(0..abs(from1x - to1x), fn delta -> {min_x + delta, max_y - delta} end)
  end
end
