defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task

  def run args do
    {opts, _} = OptionParser.parse!(args,
      switches: [
        input: :boolean,
        tests: :boolean,
        solution: :boolean,
        day: :integer,
      ])

    day = opts[:day]

    if day == nil do
      Mix.shell().error([:red, "Error: ", :reset, "You must specify a day."])
      System.halt(1)
    end

    if not (c(opts[:solution]) or c(opts[:tests]) or c(opts[:input])) do
      Mix.shell().error([:yellow, "Warning: ", :reset, "You should specify some action. This command is a no-op without them."])
    end

    if opts[:solution] do
      create_implfile day
    end

    if opts[:tests] do
      create_testfile day
    end

    if opts[:input] do
      create_input day
    end

    :ok
  end

  defp c(v) when is_nil(v) do
    false
  end
  defp c(v) when is_boolean(v) do
    v
  end

  defp create_input day do
    cookie = File.read!(Path.relative_to_cwd("cookie.txt"))

    {:ok, {{_proto_version, status_code, status_text}, _hdrs, body}} = :httpc.request(:get,
      {
        "https://adventofcode.com/2021/day/#{day}/input",
        [{'Cookie', 'session=#{cookie}'}]
      }, [ssl: [verify: :verify_peer, cacertfile: '/etc/ssl/cert.pem']], [sync: true])

    if status_code != 200 do
      Mix.shell().error([:red, "Error: ", :reset, " Could not download inputs: #{status_text}"])
    else
      Mix.Generator.create_file("priv/day#{day}.txt", body)
    end

    :ok
  end

  defp create_implfile day do
    Mix.Generator.create_file("lib/solutions/day#{day}.ex", """
    defmodule Aoc2021.Solution.Day#{day} do
      @behaviour Aoc2021.Solution

      @impl Aoc2021.Solution
      def parse text do

      end

      @impl Aoc2021.Solution
      def part1 input do

      end

      @impl Aoc2021.Solution
      def part2 input do

      end
    end
    """)
  end

  defp create_testfile day do
    Mix.Generator.create_file("test/solutions/day#{day}_test.exs", """
    defmodule Aoc2021.Solution.Day#{day}Test do
      use ExUnit.Case, async: true
      doctest Aoc2021.Solution.Day#{day}

      test "Part 1" do

      end

      test "Part 2" do

      end
    end
    """)
  end
end
