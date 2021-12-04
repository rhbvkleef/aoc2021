defmodule Aoc do
  defmacro aoc year, day, do: body do
    quote do
      defmodule unquote(modulename(year, day)) do
        @behaviour Aoc.Solution

        unquote(body)
      end
    end
  end

  defmacro aoc_test year, day, do: body do
    quote do
      defmodule unquote(Module.concat([Aoc.SolutionTests, String.to_atom("Year#{year}"), String.to_atom("Day#{day}")])) do
        use ExUnit.Case, async: true

        defmacrop mod, do: unquote(modulename(year, day))

        doctest unquote(modulename(year, day))

        unquote(body)
      end
    end
  end

  def modulename(year, day) do
    Module.concat([Aoc.Solutions, String.to_atom("Year#{year}"), String.to_atom("Day#{day}")])
  end

  @doc "Convert input text into an array of strings, representing lines."
  @spec strings1d(binary) :: [binary]
  def strings1d text do
    text
      |> String.split("\n", trim: true)
  end

  @doc "Convert input text into a 2d array of characters."
  @spec chars2d(binary) :: [[char]]
  def chars2d text do
    text
      |> strings1d
      # This assumes that all input is latin1, which it is.
      #  It's slightly faster than using &String.to_charlist/1 as we don't
      #  have to deal with unicode nonsense.
      |> Enum.map(&:erlang.binary_to_list/1)
  end

  @doc "Convert input text into an array of integers, with each line containing an integer."
  @spec integers1d(binary) :: [integer]
  def integers1d text do
    text
      |> strings1d
      |> Enum.map(&String.to_integer/1)
  end

  @doc "Convert input text into a 2d array of strings, where each line contains a space-separate list of strings."
  @spec strings2d(binary) :: [[binary]]
  def strings2d text do
    text
      |> strings1d
      |> Enum.map(&(String.split(&1, " ")))
  end

  @doc "Using the mapping function, map each line to a tuple of values"
  @spec tuples1d(binary, tuple) :: [tuple]
  def tuples1d text, mapping do
    funs = Tuple.to_list(mapping)

    text
      |> strings2d
      |> Enum.map(fn cols ->
        Enum.zip([funs, cols])
          |> Enum.map(fn {fun, col} -> apply(fun, [col]) end)
      end)
      |> Enum.map(&List.to_tuple/1)
  end
end
