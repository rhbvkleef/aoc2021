defmodule Aoc2021 do

  @otp_app Mix.Project.config()[:app]
  def run do
    dir = Application.app_dir(@otp_app, "priv")
    files = Path.wildcard(dir <> "/day*.txt")
    modules = files |> Enum.map(fn file -> {get_module(file), file} end)

    IO.inspect(modules |> Enum.map(&run_module/1))
  end

  @spec integers(list(binary())) :: list(integer())
  def integers lines do
    lines
      |> Enum.map(&String.to_integer/1)
  end

  defp get_module name do
    modulename = name
      |> Path.basename
      |> String.split(".")
      |> hd
      |> String.capitalize

    String.to_atom("Elixir.Aoc2021.Solution." <> modulename)
  end

  defp run_module({module, file}) do
    lines = file
      |> File.read!
      |> String.split("\n", trim: true)

    part1 = if Keyword.has_key?(module.__info__(:functions), :part1) do
      module.part1 lines
    else
      nil
    end

    part2 = if Keyword.has_key?(module.__info__(:functions), :part2) do
      module.part2 lines
    else
      nil
    end

    {module, part1, part2}
  end
end
