defmodule Mix.Tasks.Aoc do
  use Mix.Task

  def run args do
    {params, _} = OptionParser.parse!(args,
      switches: [
        day: [:integer, :keep]
      ]
    )

    days = params
      |> Enum.filter(&(elem(&1, 0) == :day))
      |> Enum.map(&(elem(&1, 1)))

    if Enum.empty?(days) do
      Aoc2021.run
    else
      Aoc2021.run(days)
    end
  end
end
