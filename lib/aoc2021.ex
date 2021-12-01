defmodule Aoc2021 do

  @otp_app Mix.Project.config()[:app]

  @doc "Main entry-point"
  def run do
    dir = Application.app_dir(@otp_app, "priv")
    files = Path.wildcard(dir <> "/day*.txt")
    modules = files |> Enum.map(fn file -> {get_module(file), file} end)

    modules
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

  defp get_module name do
    modulename = name
      |> Path.basename
      |> Path.rootname
      |> String.capitalize

    String.to_atom("Elixir.Aoc2021.Solution." <> modulename)
  end

  defp run_module({module, file}) do
    {iotime, text} = :timer.tc(File, :read!, [file])
    {parsetime, input} = :timer.tc(module, :parse, [text])
    part1 = :timer.tc(module, :part1, [input])
    part2 = :timer.tc(module, :part2, [input])

    {module, iotime, parsetime, part1, part2}
  end

  defp format_output {module, iotime, parsetime, part1, part2} do
    IO.puts("#{module |> to_string() |> String.split(".") |> List.last}:")
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
