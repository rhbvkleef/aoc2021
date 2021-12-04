defmodule Aoc2021.Solution.Day4 do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  def parse text do
    [calls|rest] = String.split(text, "\n")
    numbers = String.split(calls, ",")

    boards = tl(rest)
      |> Enum.chunk_while([], fn "", acc -> {:cont, Enum.reverse(acc), []}
      el, acc -> {:cont, [el | acc]} end, fn [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []} end)
      |> Enum.map(&parse_board/1)

    {numbers, boards}
  end

  defp parse_board([""|lines]), do: parse_board(lines)
  defp parse_board([line|lines]) do
    [String.split(line, " ", trim: true) | parse_board lines]
  end
  defp parse_board([]), do: []

  @impl Aoc2021.Solution
  def part1 {[number|numbers], boards} do
    applied = Enum.map(boards, &(apply_number(number, &1)))

    match = Enum.find(applied, &(elem(&1, 0)))

    if match == nil do
      part1{numbers, Enum.map(applied, &(elem(&1, 1)))}
    else
      {_, board} = match
      remaining_sum = List.flatten(board)
        |> Enum.filter(&(&1 != :tick))
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum

      remaining_sum * String.to_integer(number)
    end
  end

  defp apply_number(number, board, columns \\ nil)
  defp apply_number(number, board, nil),
    do: apply_number(number, board, List.duplicate(true, length(hd(board))))
  defp apply_number(number, [line|lines], columns) do
    new_line = Enum.map(line, fn ^number -> :tick
      num -> num end)

    new_columns = Enum.zip(new_line, columns)
      |> Enum.map(fn {l, r} -> l == :tick and r end)

    {match, rest_board} = apply_number(number, lines, new_columns)

    {match or Enum.all?(new_line, &(&1 == :tick)), [new_line|rest_board]}
  end
  defp apply_number(_, [], columns), do: {Enum.any?(columns), []}

  @impl Aoc2021.Solution
  def part2 {[number|numbers], boards} do
    applied = Enum.map(boards, &(apply_number(number, &1)))

    unfinished = Enum.filter(applied, &(not elem(&1, 0)))

    case unfinished do
      [{_, board}] -> part1{[number|numbers], [board]}
      _ -> part2{numbers, Enum.map(unfinished, &(elem(&1, 1)))}
    end
  end
end
