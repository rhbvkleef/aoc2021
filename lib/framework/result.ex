defmodule Aoc.Result do
  defstruct [:year, :day, :iotime, :parsetime, :part1time, :part2time, :part1result, :part2result]

  def fmt(%Aoc.Result{}=this) do
    part1result = inspect(this.part1result)
    part2result = inspect(this.part2result)
    """
    Year #{this.year} day #{this.day}
      IO took:     #{this.iotime}µs
      Parse took:  #{this.parsetime}µs
      Part 1 took: #{this.part1time}µs
    #{indent(part1result, "    ")}
      Part 2 took: #{this.part2time}µs
    #{indent(part2result, "    ")}
    """
  end

  defp indent(string, dent) do
    string
    |> String.split("\n", trim: true)
    |> Enum.map(&"#{dent}#{&1}")
    |> Enum.join("\n")
  end
end
