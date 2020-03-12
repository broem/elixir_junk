defmodule CardsTest do
  use ExUnit.Case
  doctest Cards
  
  test "create_deck makes 52 cards" do
    deck_len = length(Cards.create_deck)
    assert deck_len == 52
  end

  test "shuffle mixes the cards" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

  test "create_hand makes a deck of a given size" do
    {hand, rest} = Cards.create_hand(5)
    assert length(hand) == 5
  end
end
