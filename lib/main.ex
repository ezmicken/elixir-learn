defmodule Smoggach.RUN do
  def main(args \\ []) do
    Smoggach.annagrams?(Enum.at(args, 0), Enum.at(args, 1))
    |> IO.puts()
  end
end
