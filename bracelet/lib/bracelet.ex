defmodule Bracelet do
  def same_necklace(first, second) do
    String.length(first) == String.length(second) && String.contains?("#{second}#{second}", first)
  end
end
