import Aoc

aoc 2021, 9 do
  @impl Aoc.Solution
  def parse(text) do
    Aoc.chars2d(text)
    |> Enum.with_index
    |> Enum.flat_map(fn {line, rownum} ->
      Enum.with_index(line)
      |> Enum.map(fn {chr, colnum} ->
        {{rownum, colnum}, chr - ?0}
      end)
    end)
    |> Enum.into(%{})
  end

  @impl Aoc.Solution
  def part1(input) do
    low_points(input)
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&(&1 + 1))
    |> Enum.sum
  end

  @impl Aoc.Solution
  def part2(input) do
    low_points(input)
    |> Enum.map(&get_basin(MapSet.new(), elem(&1, 0), input))
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product
  end

  defp get_basin(current, {x, y} = point, map) do
    if point in current or Map.get(map, point, 9) == 9 do
      current
    else
      current
      |> MapSet.put(point)
      |> get_basin({x + 1, y}, map)
      |> get_basin({x - 1, y}, map)
      |> get_basin({x, y + 1}, map)
      |> get_basin({x, y - 1}, map)
    end
  end

  defp low_points(map) do
    Enum.flat_map(map, fn {{x, y}, score} ->
      if map[{x-1,y}] > score and
         map[{x+1,y}] > score and
         map[{x,y-1}] > score and
         map[{x,y+1}] > score do
        [{{x, y}, score}]
      else
        []
      end
    end)
  end
end
