defmodule AdventOfCode.Day05 do
  def part1(input) do
    input
    |> parse_input()
    |> follow_reverse_instructions()
    |> select_last()
  end

  def part2(input) do
    input
    |> parse_input()
    |> follow_in_order_instructions()
    |> select_last()
  end

  defp parse_input(input) do
    [initial_stacks, instructions] =
      input
      |> String.split("\n\n")

    {parse_initial_stacks(initial_stacks), parse_instructions(instructions)}
  end

  defp parse_initial_stacks(initial_stacks) do
    all_rows =
      initial_stacks
      |> String.split("\n")
      |> Enum.drop(-1)

    length = String.length(List.last(all_rows))

    all_rows
    |> Enum.map(fn row ->
      row
      |> String.pad_trailing(length)
      |> String.graphemes()
      |> Enum.chunk_every(4)
      |> Enum.map(fn chunk ->
        chunk
        |> Enum.reject(&(&1 in [" ", "[", "]"]))
      end)
    end)
    |> Enum.zip()
    |> Enum.map(fn stack ->
      stack
      |> Tuple.to_list()
      |> Enum.reject(&(&1 == []))
    end)
  end

  defp parse_instructions(instructions) do
    instructions
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn row ->
      parsed_row = String.split(row, " ")

      %{
        n: parse_integer(parsed_row, 1),
        from: parse_integer(parsed_row, 3) - 1,
        to: parse_integer(parsed_row, 5) - 1
      }
    end)
  end

  defp parse_integer(row, n) do
    row
    |> Enum.at(n)
    |> String.to_integer()
  end

  defp follow_reverse_instructions({initial_stacks, instructions}) do
    instructions
    |> Enum.reduce(initial_stacks, fn %{n: count, from: from, to: to}, stacks ->
      from_stacks = Enum.at(stacks, from)
      to_stacks = Enum.at(stacks, to)

      {stacks_to_move, remaining_stacks} =
        from_stacks
        |> Enum.split(count)

      stacks
      |> List.replace_at(from, remaining_stacks)
      |> List.replace_at(to, Enum.reverse(stacks_to_move) ++ to_stacks)
    end)
  end

  defp follow_in_order_instructions({initial_stacks, instructions}) do
    instructions
    |> Enum.reduce(initial_stacks, fn %{n: count, from: from, to: to}, stacks ->
      from_stacks = Enum.at(stacks, from)
      to_stacks = Enum.at(stacks, to)

      {stacks_to_move, remaining_stacks} =
        from_stacks
        |> Enum.split(count)

      stacks
      |> List.replace_at(from, remaining_stacks)
      |> List.replace_at(to, stacks_to_move ++ to_stacks)
    end)
  end

  defp select_last(stacks) do
    stacks
    |> Enum.map(&List.first(&1))
    |> Enum.join()
  end
end
