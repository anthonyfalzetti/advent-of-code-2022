defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  @input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  test "part1" do
    result = part1(@input)

    assert result == 2
  end

  @tag :skip
  test "part2" do
    result = part2(@input)

    assert result == 4
  end
end
