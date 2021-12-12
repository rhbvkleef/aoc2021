import Aoc

aoc 2021, 10 do
  @impl Aoc.Solution
  def parse(text) do
    Aoc.chars2d(text)
  end

  @impl Aoc.Solution
  def part1(input) do
    Enum.map(input, &do_line/1)
    |> Enum.map(fn
      {[], _} -> 0
      {[?)|_], _} -> 3
      {[?]|_], _} -> 57
      {[?}|_], _} -> 1197
      {[?>|_], _} -> 25137
    end)
    |> Enum.sum
  end

  @impl Aoc.Solution
  def part2(input) do
    scores = Enum.map(input, &do_line/1)
    |> Enum.flat_map(fn
      {[_|_], _} -> []
      {[], remainder} -> [incompleteness_score(remainder)]
      _ -> []
    end)
    |> Enum.sort

    Enum.at(scores, floor(length(scores) / 2.0))
  end

  defp do_line(remaining, state \\ [])
  defp do_line([cur|rest], state) when cur in [?[, ?<, ?{] do
    do_line(rest, [cur + 2|state])
  end
  defp do_line([?(|rest], state) do
    do_line(rest, [?)|state])
  end
  defp do_line([cur|rest], [cur|rest_state]) do
    do_line(rest, rest_state)
  end
  defp do_line(leftover, leftover_state) do
    {leftover, leftover_state}
  end

  defp incompleteness_score(str, score \\ 0)
  defp incompleteness_score([chr|chars], score) do
    new_score = (5 * score) + case chr do
      ?) -> 1
      ?] -> 2
      ?} -> 3
      ?> -> 4
    end

    incompleteness_score(chars, new_score)
  end
  defp incompleteness_score([], score), do: score
end
