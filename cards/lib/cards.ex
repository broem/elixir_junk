defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do 
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, amount) do
    Enum.split(deck, amount)
  end

  def save(deck, path) do
    binary = :erlang.term_to_binary(deck)
    File.write(path, binary)
  end

  def load(path) do
    case File.read(path) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File doesnt exist" 
    end
  end
  
  def create_hand(size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(size)
  end
end
