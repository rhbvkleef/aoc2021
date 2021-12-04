defmodule Aoc.Solution do
  @callback parse(binary) :: any
  @callback part1(any) :: any
  @callback part2(any) :: any

  def run(year, day, file) do
    module = Aoc.modulename(year, day)

    {iotime, text} = :timer.tc(File, :read!, [file])
    {parsetime, input} = :timer.tc(module, :parse, [text])
    part1 = :timer.tc(module, :part1, [input])
    part2 = :timer.tc(module, :part2, [input])

    {year, day, iotime, parsetime, part1, part2}
  end
end
