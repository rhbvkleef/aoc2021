import Aoc

aoc 2021, 2 do
  @impl Aoc.Solution
  def parse(text), do: Aoc.tuples1d(text, {:atom, :integer})

  @impl Aoc.Solution
  def part1(input) do
    input
      |> Enum.reduce({0, 0}, fn
          {:forward, amount}, {horiz, depth} -> {horiz + amount, depth}
          {:up, amount},      {horiz, depth} -> {horiz, depth - amount}
          {:down, amount},    {horiz, depth} -> {horiz, depth + amount}
        end)
      |> then(fn {horiz, depth} -> horiz * depth end)
  end

  @impl Aoc.Solution
  def part2(input) do
    input
      |> Enum.reduce({0, 0, 0}, fn
          {:forward, amount}, {horiz, depth, aim} -> {horiz + amount, depth + (aim * amount), aim}
          {:up, amount},      {horiz, depth, aim} -> {horiz, depth, aim - amount}
          {:down, amount},    {horiz, depth, aim} -> {horiz, depth, aim + amount}
        end)
      |> then(fn {horiz, depth, _} -> horiz * depth end)
  end
end
