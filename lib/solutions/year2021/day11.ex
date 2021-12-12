import Aoc

aoc 2021, 11 do
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
    Enum.reduce(1..100, {0, input}, fn _, {cnt, acc} ->
      next = step(acc)

      count = next
      |> Enum.filter(fn {_, cnt} -> cnt >= 10 end)
      |> Enum.count()

      {count + cnt, next}
    end)
    |> elem(0)
  end

  @impl Aoc.Solution
  def part2(input) do
    Enum.reduce_while(1..1000, {0, input}, fn idx, {cnt, acc} ->
      next = step(acc)

      count = next
      |> Enum.filter(fn {_, cnt} -> cnt >= 10 end)
      |> Enum.count()

      if count == 10*10 do
        {:halt, idx}
      else
        {:cont, {count + cnt, next}}
      end
    end)
  end

  defp step(map) do
    map = Enum.map(map, fn {k, cnt} ->
      if cnt >= 10, do: {k, 1}, else: {k, cnt + 1}
    end)
    |> Enum.into(%{})

    to_flash = Enum.filter(map, fn {_k, cnt} ->
      cnt == 10
    end)

    Enum.reduce(to_flash, map, &flash/2)
  end

  defp flash({coord, 10}, map) do
    to_flash = surrounding_cells(coord, map)

    map = Enum.reduce(to_flash, map, fn {coord, _}, acc -> Map.update(acc, coord, 0, &(&1 + 1)) end)

    to_flash
    |> Enum.filter(fn {_k, cnt} ->
      cnt == 9
    end)
    |> Enum.map(fn {k, _} -> {k, 10} end)
    |> Enum.reduce(map, &flash/2)
  end

  defp surrounding_cells({x, y}, map) do
    [
      {x-1,y-1},{x,y-1},{x+1,y-1},
      {x-1,y},          {x+1,y},
      {x-1,y+1},{x,y+1},{x+1,y+1},
    ]
    |> Enum.map(&{&1, Map.get(map, &1, nil)})
    |> Enum.filter(fn {_, x} -> x != nil end)
  end
end
