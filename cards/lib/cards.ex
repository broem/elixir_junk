defmodule Cards do
  @moduledoc """
  Deck of Cards.
  """

  @doc """
  Returns list of strings as deck of cards
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

  @doc """
    Deals some cards given a `deck` and `amount`

  ## Examples 

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
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
