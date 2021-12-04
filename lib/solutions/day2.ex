defmodule Aoc2021.Solution.Day2 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  def parse(text),
    do: Aoc2021.tuples1d(text, {&String.to_existing_atom/1, &String.to_integer/1})

  @impl Aoc2021.Solution
  def part1(input, coordinates \\ {0, 0})
  def part1([{instruction, amount} | rest], {horiz, depth}),
    do: part1 rest, (case instruction do
      :forward -> {horiz + amount, depth}
      :up      -> {horiz, depth - amount}
      :down    -> {horiz, depth + amount}
    end)
  def part1([], {horiz, depth}), do: horiz * depth

  @impl Aoc2021.Solution
  def part2(input, coordinates \\ {0, 0, 0})
  def part2([{instruction, amount} | rest], {horiz, depth, aim}),
    do: part2 rest, (case instruction do
      :forward -> {horiz + amount, depth + (aim * amount), aim}
      :up      -> {horiz, depth, aim - amount}
      :down    -> {horiz, depth, aim + amount}
    end)
  def part2([], {horiz, depth, _}), do: horiz * depth
end
