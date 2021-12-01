defmodule Mix.Tasks.Aoc do
  use Mix.Task

  def run args do
    {params, _} = OptionParser.parse!(args,
      switches: [
        day: [:integer, :keep]
      ]
    )

    days = params
      |> Enum.filter(fn param -> elem(param, 0) == :day end)
      |> Enum.map(fn param -> elem(param, 1) end)

    if Enum.empty?(days) do
      Aoc2021.run
    else
      Aoc2021.run(days)
    end
  end
end
