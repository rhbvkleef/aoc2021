defmodule Mix.Tasks.Aoc do
  use Mix.Task

  def run args do
    {params, _} = OptionParser.parse!(args,
      switches: [
        year: [:integer, :keep],
        day: [:integer, :keep],
        input_root: :string,
      ]
    )

    years = params
      |> Enum.filter(&(elem(&1, 0) == :year))
      |> Enum.map(&elem(&1, 1))

    days = params
      |> Enum.filter(&(elem(&1, 0) == :day))
      |> Enum.map(&elem(&1, 1))

    input_root = case params[:input_root] do
        nil  -> "priv/inputs"
        path -> path
    end

    find_inputs(input_root)
      |> Enum.filter(fn {year, _, _} -> if Enum.empty?(years) do true else Enum.member?(years, year) end end)
      |> Enum.filter(fn {_, day, _}  -> if Enum.empty?(days) do true else Enum.member?(days, day) end end)
      |> Stream.map(fn {year, day, file} -> Aoc.Solution.run(year, day, file) end)
      |> Stream.each(&format_output/1)
      |> Stream.run
  end

  defp find_inputs input_root do
    dir = Path.relative_to_cwd(input_root)

    Path.wildcard("#{dir}/year*/day*.txt")
      |> Enum.map(&{get_year_day(&1), &1})
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
      |> Enum.map(&"\t\t#{&1}")
      |> Enum.join("\n")
      |> IO.puts

    IO.puts("\tPart 2 ran in #{elem(part2, 0)}us:")
    inspect(elem(part2, 1))
      |> String.split("\n", trim: true)
      |> Enum.map(&"\t\t#{&1}")
      |> Enum.join("\n")
      |> IO.puts

    :ok
  end
end
