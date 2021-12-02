defmodule Aoc2021.Solution.Day2 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  def parse text do
    Aoc2021.strings1d(text)
      |> Enum.map(fn line -> String.split(line, " ") end)
      |> Enum.map(fn [direction, amount] -> {String.to_existing_atom(direction), String.to_integer(amount)} end)
  end

  @impl Aoc2021.Solution
  def part1(input, coordinates \\ {0, 0})
  def part1([{:forward, amount} | rest], {horiz, depth}),
    do: part1 rest, {horiz + amount, depth}
  def part1([{:up, amount} | rest], {horiz, depth}),
    do: part1 rest, {horiz, depth - amount}
  def part1([{:down, amount} | rest], {horiz, depth}),
    do: part1 rest, {horiz, depth + amount}
  def part1([], {horiz, depth}), do: horiz * depth

  @impl Aoc2021.Solution
  def part2(input, coordinates \\ {0, 0, 0})
  def part2([{:forward, amount} | rest], {horiz, depth, aim}),
    do: part2 rest, {horiz + amount, depth + (aim * amount), aim}
  def part2([{:up, amount} | rest], {horiz, depth, aim}),
    do: part2 rest, {horiz, depth, aim - amount}
  def part2([{:down, amount} | rest], {horiz, depth, aim}),
    do: part2 rest, {horiz, depth, aim + amount}
  def part2([], {horiz, depth, _}), do: horiz * depth
end
