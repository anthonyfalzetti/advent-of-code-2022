defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> separate_into_lists()
    |> List.last()
  end

  def part2(args) do
    args
    |> separate_into_lists()
    |> Enum.take(-3)
    |> Enum.sum()
  end

  defp separate_into_lists(args) do
    args
    |> String.split("\n")
    |> Enum.reduce([[]], fn
      "", acc -> [[] | acc]
      elem, [head | tail] ->
        [[String.to_integer(elem) | head] | tail]
    end)
    |> Enum.reject(&(Enum.empty?(&1)))
    |> Enum.map(&(Enum.sum(&1)))
    |> Enum.sort()
  end
end
