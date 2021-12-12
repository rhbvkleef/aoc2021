import Aoc

aoc 2021, 12 do
  @impl Aoc.Solution
  def parse(text) do
    Aoc.strings1d(text)
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.reduce(%{}, fn [from, to], acc ->
        Map.update(acc, from, MapSet.new([to]), &MapSet.put(&1, to))
        |> Map.update(to, MapSet.new([from]), &MapSet.put(&1, from))
      end)
  end

  @impl Aoc.Solution
  def part1 graph do
    count_paths(graph, "start", %{}, 1, [])
  end

  @impl Aoc.Solution
  def part2 graph do
    count_paths(graph, "start", %{"start" => 1}, 2, [])
  end

  def visit_cost(<<f, _::binary>>) when f in ?A..?Z, do: 0
  def visit_cost(_), do: 1

  def count_paths(graph, current, visited, max_score, path) do
    visited = Map.update(visited, current, visit_cost(current), &(&1 + visit_cost(current)))
    max_score = if Map.get(visited, current, 0) == 2 and current != "start", do: 1, else: max_score

    case current do
      "end" -> 1
      _ -> Enum.filter(Map.get(graph, current, []), &(Map.get(visited, &1, 0) < max_score))
           |> Enum.map(&count_paths(graph, &1, visited, max_score, [current|path]))
           |> Enum.sum
    end
  end
end
