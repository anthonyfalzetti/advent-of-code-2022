defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> String.graphemes()
    |> Enum.chunk_every(4, 1, :discard)
    |> find_index(4)
  end

  def part2(input) do
    input
    |> String.graphemes()
    |> Enum.chunk_every(14, 1, :discard)
    |> find_index(14)
  end

  defp find_index(list, count) do
    inx = list
    |> Enum.find_index(fn(list) ->
      list
      |> MapSet.new()
      |> Enum.count() == count
    end)

    inx + count
  end
end
