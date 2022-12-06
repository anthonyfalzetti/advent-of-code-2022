defmodule AdventOfCode.Day03 do
  @letter_range (Enum.to_list(?a..?z) ++ Enum.to_list(?A..?Z))
                |> List.to_string()
                |> String.graphemes()

  def part1(args) do
    args
    |> parse_list()
    |> split_line()
    |> Enum.map(&find_item/1)
    |> Enum.map(&find_value/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> parse_list()
    |> Enum.chunk_every(3)
    |> Enum.map(fn chunk ->
      chunk
      |> Enum.map(&string_to_mapset/1)
      |> find_item()
      |> find_value()
    end)
    |> Enum.sum()
  end

  defp parse_list(string) do
    string
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
  end

  defp split_line(line) do
    line
    |> Enum.map(fn row ->
      l =
        row
        |> String.length()
        |> div(2)

      {first_string, second_string} = String.split_at(row, l)
      {string_to_mapset(first_string), string_to_mapset(second_string)}
    end)
  end

  defp find_item({map_set, other_map_set}),
    do: MapSet.intersection(map_set, other_map_set) |> MapSet.to_list()

  defp find_item([ms1, ms2, ms3]) do
    ms1
    |> MapSet.intersection(ms2)
    |> MapSet.intersection(ms3)
    |> MapSet.to_list()
  end

  defp find_value([elem | _tail]), do: Enum.find_index(@letter_range, &(&1 == elem)) + 1

  defp string_to_mapset(string) do
    string
    |> String.graphemes()
    |> MapSet.new()
  end
end
