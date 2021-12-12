defmodule Aoc.Solution do
  @callback parse(binary) :: any
  @callback part1(any) :: any
  @callback part2(any) :: any

  def run(year, day, file) do
    module = Aoc.modulename(year, day)

    {iotime, text} = :timer.tc(File, :read!, [file])
    {parsetime, input} = :timer.tc(module, :parse, [text])
    {part1time, part1result} = :timer.tc(module, :part1, [input])
    {part2time, part2result} = :timer.tc(module, :part2, [input])

    %Aoc.Result{
      year:        year,
      day:         day,
      iotime:      iotime,
      parsetime:   parsetime,
      part1time:   part1time,
      part1result: part1result,
      part2time:   part2time,
      part2result: part2result,
    }
  end
end
