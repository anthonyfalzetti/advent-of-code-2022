defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> parse_list()
    |> Enum.map(&parse_part_1/1)
    |> Enum.map(&apply_standard_method/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> parse_list()
    |> Enum.map(&parse_part_2/1)
    |> Enum.map(&apply_standard_method/1)
    |> Enum.sum()
  end

  defp parse_list(string) do
    string
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.reject(&(&1 == [""]))
  end

  defp apply_standard_method([opp, mine]) do
    points_for_mine(mine) + points_for_result(opp, mine)
  end

  defp parse_part_1([opp, mine]), do: [parse(opp), parse(mine)]
  defp parse_part_2([opp, mine]) do
    opp_parsed = parse(opp)

    mine_parsed = mine
    |> parse_result()
    |> determine_mine(opp_parsed)

    [opp_parsed, mine_parsed]
  end

  defp parse("A"), do: "rock"
  defp parse("B"), do: "paper"
  defp parse("C"), do: "scissors"
  defp parse("X"), do: "rock"
  defp parse("Y"), do: "paper"
  defp parse("Z"), do: "scissors"

  defp parse_result("X"), do: "lose"
  defp parse_result("Y"), do: "draw"
  defp parse_result("Z"), do: "win"

  defp points_for_mine("rock"), do: 1
  defp points_for_mine("paper"), do: 2
  defp points_for_mine("scissors"), do: 3

  defp points_for_result(opp, opp), do: 3
  defp points_for_result("rock", "paper"), do: 6
  defp points_for_result("scissors", "rock"), do: 6
  defp points_for_result("paper", "scissors"), do: 6
  defp points_for_result(_, _), do: 0

  defp determine_mine("draw", opp), do: opp
  defp determine_mine("lose", "rock"), do: "scissors"
  defp determine_mine("lose", "scissors"), do: "paper"
  defp determine_mine("lose", "paper"), do: "rock"
  defp determine_mine("win", "rock"), do: "paper"
  defp determine_mine("win", "scissors"), do: "rock"
  defp determine_mine("win", "paper"), do: "scissors"
end
