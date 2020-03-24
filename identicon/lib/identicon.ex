defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odds
    |> build_pixel_map
    |> draw_image
    |> save(input)
  end

  def save(image, filename) do
    File.write!("#{filename}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, location: location}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each location, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)

  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    location =
      Enum.map(grid, fn {_code, index} ->
        horz = rem(index, 5) * 50
        vert = div(index, 5) * 50
        top_left = {horz, vert}
        bottom_right = {horz + 50, vert + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | location: location}
  end

  def filter_odds(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      # & <- says im about to pass a reference to a function
      # /1 <- says its got 1 parameter
      # could be written as a helper fn(x) =>
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [12, 4, 66]
    [first, second | _tail] = row

    # [12, 4, 66, 4, 12]
    # ++ joins lists
    row ++ [second, first]
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = img) do
    # %Identicon.Image{hex: [r, g, b | _tail]} = img
    # [r,g,b | _tail ] = hex_list
    # [r, g, b]
    # makes a new object
    %Identicon.Image{img | color: {r, g, b}}
  end
end
