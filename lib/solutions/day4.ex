defmodule Aoc2021.Solution.Day4 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  def parse text do
    [calls, ""|rest] = String.split(text, "\n")
    numbers = String.split(calls, ",")

    boards = rest
      |> Enum.chunk_by(&(&1 != ""))
      |> Enum.reject(&(&1 == [""]))
      |> Enum.map(fn board -> Enum.map(board, &(String.split(&1, " ", trim: true))) end)

    {numbers, boards}
  end

  @impl Aoc2021.Solution
  def part1 {[number|numbers], boards} do
    applied = Enum.map(boards, &(apply_number(number, &1)))

    case Enum.find(applied, &(elem(&1, 0))) do
      nil -> part1{numbers, Enum.map(applied, &(elem(&1, 1)))}
      {_, board} -> List.flatten(board)
        |> Enum.filter(&(&1 != :tick))
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum
        |> then(&(&1 * String.to_integer(number)))
    end
  end

  defp apply_number(number, board, columns \\ nil)
  defp apply_number(number, board, nil),
    do: apply_number(number, board, List.duplicate(true, length(hd(board))))
  defp apply_number(number, [line|lines], columns) do
    new_line = Enum.map(line, fn ^number -> :tick
      num -> num end)

    {match, rest_board} = Enum.zip(new_line, columns)
      |> Enum.map(fn {l, r} -> l == :tick and r end)
      |> then(&(apply_number(number, lines, &1)))

    {match or Enum.all?(new_line, &(&1 == :tick)), [new_line|rest_board]}
  end
  defp apply_number(_, [], columns), do: {Enum.any?(columns), []}

  @impl Aoc2021.Solution
  def part2 {[number|numbers], boards} do
    applied = Enum.map(boards, &(apply_number(number, &1)))

    case Enum.filter(applied, &(not elem(&1, 0))) do
      [{_, board}] -> part1{[number|numbers], [board]}
      unfinished   -> part2{numbers, Enum.map(unfinished, &(elem(&1, 1)))}
    end
  end
end
