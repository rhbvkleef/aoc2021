import Aoc

aoc 2021, 7 do
  @impl Aoc.Solution
  def parse(text), do: String.split(text, [",", "\n"], trim: true) |> Enum.map(&String.to_integer/1)

  @impl Aoc.Solution
  def part1(input) do
    median = Enum.sort(input) |> Enum.at(floor(length(input) / 2))

    Enum.map(input, &abs(median - &1)) |> Enum.sum
  end

  @impl Aoc.Solution
  def part2(input) do
    mean = floor(Enum.sum(input) / length(input))

    Enum.map((mean - 5)..(mean + 5), fn offset ->
      Enum.map(input, fn crab ->
        num = abs(offset - crab)
        round((num / 2) * (1 + num))
      end) |> Enum.sum
    end)
      |> Enum.min(fn -> nil end)
  end
end
