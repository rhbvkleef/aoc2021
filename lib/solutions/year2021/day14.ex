import Aoc

aoc 2021, 14 do
  @impl Aoc.Solution
  def parse(text) do
    [input|function_strings] = Aoc.chars2d(text)

    char_indexes = function_strings
    |> Enum.map(&hd/1)
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.into(%{})

    functions = function_strings
    |> Enum.map(fn [c1, c2, ?\s, ?-, ?>, ?\s, c3] ->
      {[c1, c2], {[c1, c3], [c3, c2]}}
    end)

    input_pairs = input
    |> Enum.chunk_every(2, 1, :discard)

    {char_indexes, input_pairs, functions}
  end

  @impl Aoc.Solution
  def part1({indices, pairs, functions}, iterations \\ 10) do
    matrix_dimension = map_size(indices) * map_size(indices) - 1

    # Convert the input functions to vectors that will become part of the function matrix
    index_functions = functions
    |> Enum.map(fn {k, {p1, p2}} ->
      {pair2index(k, indices), List.duplicate(0, map_size(indices) * map_size(indices)) |> List.update_at(pair2index(p1, indices), &(&1 + 1)) |> List.update_at(pair2index(p2, indices), &(&1 + 1))}
    end)
    |> Enum.into(%{})

    # Calculate the tensor that runs one iteration
    single_iteration_function_tensor = Enum.map(0..matrix_dimension, fn idx ->
      Map.get(index_functions, idx, List.duplicate(0, map_size(indices) * map_size(indices)) |> List.replace_at(idx, 1))
    end)
    |> Nx.tensor

    # Calculate the matrix that runs all the iterations
    function_tensor = Nx.LinAlg.matrix_power(single_iteration_function_tensor, iterations)

    # Count the pairs in the input
    input_pair_counts = pairs
    |> Enum.map(&pair2index(&1, indices))
    |> Enum.frequencies()

    # Create the input vector
    input_tensor = Enum.map(0..matrix_dimension, fn idx ->
      Map.get(input_pair_counts, idx, 0)
    end)
    |> Nx.tensor

    # Calculate the final pair counts
    result_tensor = Nx.dot(input_tensor, function_tensor)

    # Convert the final pair counts to character counts
    result = Nx.to_batched_list(result_tensor, map_size(indices))
    |> Enum.map(&Nx.sum/1)
    |> Enum.map(&Nx.to_number/1)
    # Make sure to count the last character too
    |> List.update_at(Map.get(indices, List.last(List.last(pairs))), &(&1 + 1))

    Enum.max(result) - Enum.min(result)
  end

  @impl Aoc.Solution
  def part2(input) do
    part1(input, 40)
  end

  def pair2index([a, b], indices) do
    %{^a => aidx, ^b => bidx} = indices

    (map_size(indices) * aidx) + bidx
  end
end
