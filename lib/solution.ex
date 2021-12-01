defmodule Aoc2021.Solution do
  @doc "Parse the input into a format accepted by both part1/1 and part2/1"
  @callback parse(binary) :: any

  @doc "Solve for part1"
  @callback part1(any) :: any

  @doc "Solve for part2"
  @callback part2(any) :: any
end
