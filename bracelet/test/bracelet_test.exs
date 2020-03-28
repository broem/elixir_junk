defmodule BraceletTest do
  use ExUnit.Case
  doctest Bracelet

  test "greets the world" do
    assert Bracelet.hello() == :world
  end
end
