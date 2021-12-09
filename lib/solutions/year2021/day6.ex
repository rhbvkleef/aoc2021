import Aoc

aoc 2021, 6 do
  import Nx, only: [sigil_M: 2]

  @impl Aoc.Solution
  def parse(text) do
    frequencies = String.split(text, [",", "\n"], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies

    Enum.map(0..8, fn idx ->
      Map.get(frequencies, idx, 0)
    end)
      |> Nx.tensor
  end

  @impl Aoc.Solution
  def part1(counters, remaining_days \\ 80) do
    matrix = ~M"""
      0 1 0 0 0 0 0 0 0
      0 0 1 0 0 0 0 0 0
      0 0 0 1 0 0 0 0 0
      0 0 0 0 1 0 0 0 0
      0 0 0 0 0 1 0 0 0
      0 0 0 0 0 0 1 0 0
      1 0 0 0 0 0 0 1 0
      0 0 0 0 0 0 0 0 1
      1 0 0 0 0 0 0 0 0
      """

    function = dot_power(matrix, remaining_days)

    Nx.dot(function, counters) |> Nx.sum |> Nx.to_number
  end

  @impl Aoc.Solution
  def part2(input) do
    part1(input, 256)
  end

  ##
  # Matrix exponentiation
  # Source: https://github.com/elixir-nx/nx/pull/583
  # Author: @rhbvkleef (me)
  ##

  import Nx.Defn.Kernel, only: [assert_shape_pattern: 2]

  def dot_power(tensor, power) when is_integer(power) and power < 0 do
    dot_power(Nx.LinAlg.invert(tensor), -power)
  end

  def dot_power(tensor, 0) do
    # We need a special-case for 0 since the code below
    # is optimized to not compute an initial eye.
    Nx.Defn.Kernel.assert_shape_pattern(tensor, {x, x})

    Nx.eye(tensor)
  end

  def dot_power(tensor, power) when is_integer(power) do
    Nx.Defn.Kernel.assert_shape_pattern(tensor, {x, x})

    power
    |> Integer.digits(2)
    |> tl()
    |> Enum.reverse()
    |> Enum.reduce({nil, tensor}, fn
      1, {nil, exp_tensor} ->
        {exp_tensor, Nx.dot(exp_tensor, exp_tensor)}

      1, {result_tensor, exp_tensor} ->
        {Nx.dot(result_tensor, exp_tensor), Nx.dot(exp_tensor, exp_tensor)}

      0, {result_tensor, exp_tensor} ->
        {result_tensor, Nx.dot(exp_tensor, exp_tensor)}
    end)
    |> then(fn
      {nil, exp_tensor} -> exp_tensor
      {result, exp_tensor} -> Nx.dot(result, exp_tensor)
    end)
  end
end
