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

    function = Nx.LinAlg.matrix_power(matrix, remaining_days)

    Nx.dot(function, counters) |> Nx.sum |> Nx.to_number
  end

  @impl Aoc.Solution
  def part2(input) do
    part1(input, 256)
  end
end
