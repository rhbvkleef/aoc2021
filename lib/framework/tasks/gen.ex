defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task

  def run args do
    {opts, _} = OptionParser.parse!(args,
      switches: [
        input: :boolean,
        solution: :boolean,
        year: :integer,
        day: :integer,
      ])

    day = opts[:day]
    year = opts[:year]

    if day == nil do
      Mix.shell().error([:red, "error: ", :reset, "You must specify a day."])
      System.halt(1)
    end

    if not (c(opts[:solution]) or c(opts[:input])) do
      Mix.shell().error([:yellow, "warning: ", :reset, "You should specify some action. This command is a no-op without them."])
    end

    year = if year == nil do
      y = DateTime.utc_now |> Map.fetch!(:year)
      Mix.shell().error([:blue, "info: ", :reset, "Year not specified. Implying the year: #{y}"])
      y
    else
      year
    end

    if opts[:solution] do
      create_implfile year, day
      create_testfile year, day
    end

    if opts[:input] do
      create_input year, day
    end

    :ok
  end

  defp c(nil), do: false
  defp c(v) when is_boolean(v), do: v

  defp create_input year, day do
    cookie = File.read!(Path.relative_to_cwd("cookie.txt"))

    {:ok, {{_proto_version, status_code, status_text}, _hdrs, body}} = :httpc.request(:get,
      {
        "https://adventofcode.com/#{year}/day/#{day}/input",
        [{'Cookie', 'session=#{cookie}'}]
      }, [ssl: [verify: :verify_peer, cacertfile: '/etc/ssl/cert.pem']], [sync: true])

    if status_code != 200 do
      Mix.shell().error([:red, "Error: ", :reset, " Could not download inputs: #{status_text}"])
    else
      Mix.Generator.create_file("priv/inputs/year#{year}/day#{day}.txt", body)
    end

    :ok
  end

  defp create_implfile year, day do
    Mix.Generator.create_file("lib/solutions/year#{year}/day#{day}.ex", """
    import Aoc

    aoc #{year}, #{day} do
      @impl Aoc.Solution
      def parse(text) do

      end

      @impl Aoc.Solution
      def part1(input) do

      end

      @impl Aoc.Solution
      def part2(input) do

      end
    end
    """)
  end

  defp create_testfile year, day do
    Mix.Generator.create_file("test/solutions/year#{year}/day#{day}_test.exs", """
    import Aoc

    aoc_test #{year}, #{day} do
      test "Parse" do

      end

      test "Part 1" do

      end

      test "Part 2" do

      end
    end
    """)
  end
end
