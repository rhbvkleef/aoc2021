import Aoc

aoc_test 2021, 12 do
  test "Parse" do
    assert parsed() == %{
      "HN" => MapSet.new(["dc", "end", "kj", "start"]),
      "LN" => MapSet.new(["dc"]),
      "dc" => MapSet.new(["HN", "LN", "end", "kj", "start"]),
      "end" => MapSet.new(["HN", "dc"]),
      "kj" => MapSet.new(["HN", "dc", "sa", "start"]),
      "sa" => MapSet.new(["kj"]),
      "start" => MapSet.new(["HN", "dc", "kj"])
    }
  end

  test "Part 1" do
    assert @mod.part1(parsed()) == 19
  end

  test "Part 2" do
    assert @mod.part2(parsed()) == 103
  end
end
