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

  ### beginner stuff
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

  ### concurrency
  defmodule Queue do
    use GenServer

    @doc """
    GenServer.init/1 callback
    """
    def init(state), do: {:ok, state}

    @doc """
    GenServer.handle_call/3 callback
    """
    def handle_call(:dequeue, _from, [value | state]) do
      {:reply, value, state}
    end

    def handle_call(:dequeue, _from, []), do: {:reply, nil, []}
    def handle_call(:queue, _from, state), do: {:reply, state, state}

    @doc """
    GenServer.handle_cast/2 callback
    """
    def handle_cast({:enqueue, value}, state) do
      {:noreply, state ++ [value]}
    end

    ### Client API / Helper functions

    @doc """
    Start our queue and link it.
    This is a helper function
    """
    def start_link(state \\ []) do
      GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def queue, do: GenServer.call(__MODULE__, :queue)
    def dequeue, do: GenServer.call(__MODULE__, :dequeue)
    def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  end
end
