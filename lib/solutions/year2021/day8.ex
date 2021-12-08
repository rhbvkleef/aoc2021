import Aoc

aoc 2021, 8 do
  @impl Aoc.Solution
  def parse(text) do
    :erlang.binary_to_list(text)
    |> Enum.reduce(
      {_result=[], _text_acc=[], _current_examples=[], _current_output=nil},
      fn char, {result, text_acc, current_examples, current_output} ->
        case char do
          ?\n -> {[{current_examples, Enum.reverse([text_acc|current_output])}|result], [], [], nil}
          ?|  -> {result, [], current_examples, []}
          ?\  when text_acc == [] -> {result, text_acc, current_examples, current_output}
          ?\  when current_output == nil -> {result, [], [text_acc|current_examples], nil}
          ?\  ->
            {result, [], current_examples, [text_acc|current_output]}
          _ when char in ?a..?g -> {result, [char|text_acc], current_examples, current_output}
        end
      end
    )
    |> elem(0)
  end

  @impl Aoc.Solution
  def part1(input) do
    input
    |> Enum.reduce(0, fn {_example, actual}, acc ->
      Enum.reduce(actual, acc, fn elems, other_acc ->
        case length(elems) do
          2 -> 1
          3 -> 1
          4 -> 1
          7 -> 1
          _ -> 0
        end + other_acc
      end)
    end)

  end

  @impl Aoc.Solution
  def part2(input) do
    input
    |> Enum.map(&do_line/1)
    |> Enum.sum
  end

  defp do_line({example, output}) do
    sorted = Enum.sort(example, &(length(&1) < length(&2)))
    input_elements_one = Enum.at(sorted, 0)
    input_elements_four = Enum.at(sorted, 2)

    output
    |> Enum.map(fn output_digit_elements -> find_digit(output_digit_elements, {input_elements_one, input_elements_four}) end)
    |> :erlang.list_to_integer
  end

  defp find_digit(output_elements, {input_elements_one, input_elements_four}) do
    case length(output_elements) do
      2 -> ?1
      3 -> ?7
      4 -> ?4
      7 -> ?8
      5 -> case length(output_elements -- input_elements_one) do
          3 -> ?3
          4 -> case length(output_elements -- input_elements_four) do
            2 -> ?5
            3 -> ?2
          end
        end
      6 -> case length(output_elements -- input_elements_one) do
        4 -> case length(output_elements -- input_elements_four) do
          2 -> ?9
          3 -> ?0
        end
        5 -> ?6
      end
    end
  end
end
