{opts, _} = OptionParser.parse!(System.argv,
  switches: [
    only_input: :boolean,
    day: :integer,
  ])

day = opts[:day]

cookie = File.read!("#{File.cwd!}/cookie.txt")

{:ok, :saved_to_file} = :httpc.request(:get,
  {
    "https://adventofcode.com/2021/day/#{day}/input",
    [{'Cookie', 'session=#{cookie}'}]
  },
  [],
  [stream: to_charlist("#{File.cwd!}/priv/day2.txt")])

if opts[:only_input] do
  System.halt(0)
end

{:ok, file} = File.open("#{File.cwd!}/lib/solutions/day#{day}.ex", [:write])
IO.binwrite(file, """
defmodule Aoc2021.Solution.Day#{day} do
  @behaviour Aoc2021.Solution

  @impl Aoc2021.Solution
  def part1 lines do

  end

  @impl Aoc2021.Solution
  def part2 lines do

  end
end
""")
File.close(file)

{:ok, file} = File.open("#{File.cwd!}/test/solutions/day#{day}test.ex", [:write])
IO.binwrite(file, """
defmodule Aoc2021.Solution.Day#{day}test do
  use ExUnit.Case, async: true
  doctest Aoc2021.Solution.Day#{day}
end
""")
File.close(file)
