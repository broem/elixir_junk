defmodule YatzeeTest do
  use ExUnit.Case
  doctest Yatzee

  test "yahtzee_upper([1, 1, 1, 1, 3]) => 4" do
    assert Yatzee.yahtzee_upper([1, 1, 1, 1, 3]) == 4
  end

  test "yahtzee_upper([1, 1, 1, 3, 3]) => 6" do
    assert Yatzee.yahtzee_upper([1, 1, 1, 3, 3]) == 6
  end

  test "yahtzee_upper([1, 2, 3, 4, 5]) => 5" do
    assert Yatzee.yahtzee_upper([1, 2, 3, 4, 5]) == 5
  end

  test "yahtzee_upper([6, 6, 6, 6, 6]) => 30" do
    assert Yatzee.yahtzee_upper([6, 6, 6, 6, 6]) == 30
  end

end
