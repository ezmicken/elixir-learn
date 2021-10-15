defmodule Smoggach do
  @moduledoc """
  Documentation for `Smoggach`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Smoggach.hello()
      :world

  """
  def hello do
    :world
  end

  def annagrams?(a, b) when is_binary(a) and is_binary(b) do
    sort_string(a) == sort_string(b)
  end

  def sort_string(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
