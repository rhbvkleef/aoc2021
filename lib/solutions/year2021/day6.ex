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
      0 0 0 0 0 0 1 0 1
      1 0 0 0 0 0 0 0 0
      0 1 0 0 0 0 0 0 0
      0 0 1 0 0 0 0 0 0
      0 0 0 1 0 0 0 0 0
      0 0 0 0 1 0 0 0 0
      0 0 0 0 0 1 0 0 0
      0 0 0 0 0 0 1 0 0
      0 0 0 0 0 0 0 1 0
      """

    function = matrix_power(matrix, remaining_days)

    Nx.dot(counters, function) |> Nx.sum |> Nx.to_number
  end

  @impl Aoc.Solution
  def part2(input) do
    part1(input, 256)
  end

  def matrix_power(matrix, 0) do
    Nx.subtract(matrix, matrix)
  end
  def matrix_power(matrix, power) do
    Integer.digits(power, 2)
    |> Enum.reverse()
    |> Enum.reduce({nil, matrix}, fn bit, {result_matrix, exp_matrix} ->
      cond do
        result_matrix == nil && bit == 1 -> {exp_matrix, Nx.dot(exp_matrix, exp_matrix)}
        result_matrix == nil && bit == 0 -> {nil, Nx.dot(exp_matrix, exp_matrix)}
        bit == 1 -> {Nx.dot(result_matrix, exp_matrix), Nx.dot(exp_matrix, exp_matrix)}
        bit == 0 -> {result_matrix, Nx.dot(exp_matrix, exp_matrix)}
      end
    end)
    |> elem(0)
  end
end
