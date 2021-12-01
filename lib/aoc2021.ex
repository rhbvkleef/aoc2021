defmodule Aoc2021 do
  @otp_app Mix.Project.config()[:app]

  @doc "Main entry-point"
  def run do
    find_days()
      |> Enum.map(&run_module/1)
      |> Enum.each(&format_output/1)
  end

  def run days do
    find_days()
      |> Enum.filter(fn {day, _, _} -> Enum.any?(days, fn d -> d == day end) end)
      |> Enum.map(&run_module/1)
      |> Enum.each(&format_output/1)
  end

  @doc "Convert input text into an array of strings, representing lines."
  @spec strings1d(binary) :: [binary]
  def strings1d text do
    text
      |> String.split("\n", trim: true)
  end

  @doc "Convert input text into an array of integers, with each line containing an integer."
  @spec integers1d(binary) :: [integer]
  def integers1d text do
    text
      |> strings1d
      |> Enum.map(&String.to_integer/1)
  end

  defp find_days do
    dir = Application.app_dir(@otp_app, "priv")

    Path.wildcard("#{dir}/day*.txt")
      |> Enum.map(fn f -> {get_day(f), f} end)
      |> Enum.map(fn {day, f} -> {day, f, get_module(day)} end)
  end

  defp get_day filename do
    rx = ~r/[0-9]+/
    filename
      |> Path.basename
      |> Path.rootname
      |> Kernel.then(fn name -> Regex.run(rx, name) end)
      |> hd
      |> String.to_integer
  end

  defp get_module day do
    String.to_atom("Elixir.Aoc2021.Solution.Day#{day}")
  end

  defp run_module({day, file, module}) do
    {iotime, text} = :timer.tc(File, :read!, [file])
    {parsetime, input} = :timer.tc(module, :parse, [text])
    part1 = :timer.tc(module, :part1, [input])
    part2 = :timer.tc(module, :part2, [input])

    {day, iotime, parsetime, part1, part2}
  end

  defp format_output {day, iotime, parsetime, part1, part2} do
    IO.puts("Day #{day} results:")
    IO.puts("\tFile reading took #{iotime}us")
    IO.puts("\tParsing took #{parsetime}us")

    IO.puts("\tPart 1 ran in #{elem(part1, 0)}us:")
    inspect(elem(part1, 1))
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> "\t\t#{s}" end)
      |> Enum.join("\n")
      |> IO.puts

    IO.puts("\tPart 2 ran in #{elem(part2, 0)}us:")
    inspect(elem(part2, 1))
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> "\t\t#{s}" end)
      |> Enum.join("\n")
      |> IO.puts

    :ok
  end
end
