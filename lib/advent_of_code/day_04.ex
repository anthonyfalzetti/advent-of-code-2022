defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> parse_input()
    |> count_subsets()
  end

  def part2(args) do
    args
    |> parse_input()
    |> count_overlap()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn row ->
      row
      |> String.split(",")
      |> Enum.map(&convert_to_ranges/1)
    end)
  end

  defp convert_to_ranges(string) do
    [start_elem, end_elem] =
      string
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    MapSet.new(start_elem..end_elem)
  end

  defp count_subsets(list) do
    list
    |> Enum.filter(&is_subset/1)
    |> Enum.count()
  end

  defp count_overlap(list) do
    list
    |> Enum.reject(&any_overlap/1)
    |> Enum.count()
  end

  defp is_subset([first, second]) do
    MapSet.subset?(first, second) || MapSet.subset?(second, first)
  end

  defp any_overlap([first, second]) do
    MapSet.intersection(first, second)
    |> Enum.empty?()
  end
end
