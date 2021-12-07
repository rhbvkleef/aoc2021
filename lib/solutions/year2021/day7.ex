import Aoc

aoc 2021, 7 do
  @impl Aoc.Solution
  def parse(text), do: String.split(text, [",", "\n"], trim: true) |> Enum.map(&String.to_integer/1)

  @impl Aoc.Solution
  def part1(input) do
    median = Enum.sort(input) |> Enum.at(floor(length(input) / 2))

    score(input, [median], &abs(&1 - &2))
  end

  @impl Aoc.Solution
  def part2(input) do
    mean = Enum.sum(input) / length(input)

    score(input, floor(mean)..ceil(mean), &round((abs(&1 - &2) / 2) * (abs(&1 - &2) + 1)))
  end

  defp score(input, range, score_fun) do
    Enum.map(range, fn offset ->
      Enum.map(input, &score_fun.(offset, &1)) |> Enum.sum
    end) |> Enum.min
  end
end
