import Aoc

aoc 2021, 7 do
  @impl Aoc.Solution
  def parse(text), do: String.split(text, [",", "\n"], trim: true) |> Enum.map(&String.to_integer/1)

  @impl Aoc.Solution
  def part1(input) do
    Enum.map(0..Enum.max(input), fn offset ->
      Enum.map(input, &abs(offset - &1)) |> Enum.sum
    end)
      |> Enum.min(fn -> nil end)
  end

  @impl Aoc.Solution
  def part2(input) do
    Enum.map(0..Enum.max(input), fn offset ->
      Enum.map(input, fn crab ->
        num = abs(offset - crab)
        round((num / 2) * (1 + num))
      end) |> Enum.sum
    end)
      |> Enum.min(fn -> nil end)
  end
end
