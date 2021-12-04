import Aoc

aoc 2021, 1 do
  @impl Aoc.Solution
  defdelegate parse(input), to: Aoc, as: :integers1d

  @impl Aoc.Solution
  def part1(list, count \\ 0)
  def part1([a, b | rest], count) when a < b do
    part1 [b | rest], count + 1
  end
  def part1([_a | rest], count) do
    part1 rest, count
  end
  def part1([], count), do: count

  @impl Aoc.Solution
  def part2(list, count \\ 0)
  def part2([a, b, c, d | rest], count) when a < d do
    part2 [b, c, d | rest], count + 1
  end
  def part2([_a | rest], count) do
    part2 rest, count
  end
  def part2(_list, count), do: count
end
