import Aoc

aoc 2021, 6 do
  @impl Aoc.Solution
  def parse(text) do
    String.split(text, [",", "\n"], trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  @impl Aoc.Solution
  def part1(input, remaining_days \\ 80) do
    counters = input
      |> Enum.frequencies
      |> Enum.reduce(:array.new(9, default: 0), fn {ctr, count}, array -> :array.set(ctr, count, array) end)

    Enum.reduce(0..remaining_days - 1, counters, fn _, counters ->
      new_counters = :array.new(9, default: 0)
      new_counters = :array.set(6, :array.get(0, counters), new_counters)
      new_counters = :array.set(8, :array.get(0, counters), new_counters)
      Enum.reduce(1..8, new_counters, fn ctr, new ->
        :array.set(ctr - 1, :array.get(ctr - 1, new) + :array.get(ctr, counters), new)
      end)
    end)
      |> then(&:array.to_list/1)
      |> Enum.sum
  end

  @impl Aoc.Solution
  def part2(input) do
    part1(input, 256)
  end
end
