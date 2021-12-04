defmodule Mix.Tasks.Aoc do
  use Mix.Task

  def run args do
    {params, _} = OptionParser.parse!(args,
      switches: [
        year: [:integer, :keep],
        day: [:integer, :keep],
      ]
    )

    years = params
      |> Enum.filter(&(elem(&1, 0) == :year))
      |> Enum.map(&(elem(&1, 1)))

    days = params
      |> Enum.filter(&(elem(&1, 0) == :day))
      |> Enum.map(&(elem(&1, 1)))

    find_inputs()
      |> Enum.filter(fn {year, _, _} -> if Enum.empty?(years) do true else Enum.member?(years, year) end end)
      |> Enum.filter(fn {_, day, _}  -> if Enum.empty?(days) do true else Enum.member?(days, day) end end)
      |> Enum.map(fn {year, day, file} -> Aoc.Solution.run(year, day, file) end)
      |> Enum.each(&format_output/1)
  end

  defp find_inputs do
    dir = Path.relative_to_cwd("priv")

    Path.wildcard("#{dir}/year*/day*.txt")
      |> Enum.map(&({get_year_day(&1), &1}))
      |> Enum.map(fn {{year, day}, f} -> {year, day, f} end)
  end

  defp get_year_day filename do
    [_, year, day] = Regex.run(~r/.*\/year([0-9]+)\/day([0-9]+).txt/, filename)

    {String.to_integer(year), String.to_integer(day)}
  end

  defp format_output {year, day, iotime, parsetime, part1, part2} do
    IO.puts("Year #{year} day #{day} results:")
    IO.puts("\tFile reading took #{iotime}us")
    IO.puts("\tParsing took #{parsetime}us")

    IO.puts("\tPart 1 ran in #{elem(part1, 0)}us:")
    inspect(elem(part1, 1))
      |> String.split("\n", trim: true)
      |> Enum.map(&("\t\t#{&1}"))
      |> Enum.join("\n")
      |> IO.puts

    IO.puts("\tPart 2 ran in #{elem(part2, 0)}us:")
    inspect(elem(part2, 1))
      |> String.split("\n", trim: true)
      |> Enum.map(&("\t\t#{&1}"))
      |> Enum.join("\n")
      |> IO.puts

    :ok
  end
end
