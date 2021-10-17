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

  ### chat
  def receive_message(message) do
    IO.puts message
  end
  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end
  def spawn_task(module, fun, recipient, args) do
    recipient
    |> remote_supervisor()
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  defp remote_supervisor(recipient) do
    Application.get_env(:chat, :remote_supervisor).(recipient)
  end

  ### exercises
  def fizzword(a, b, c) do
    case {a, b, c} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, c} -> c
    end
  end

  def fizzbuzz() do
    for a <- 10..16 do
      fizzword(rem(a, 3), rem(a, 5), a)
    end
  end

  def prefix(pfx) when is_binary(pfx) do
    fn(name) when is_binary(name) -> pfx <> " " <> name end
  end

  def sum(a) do
    if a > 0, do: a + sum(a - 1), else: a
  end

  def guess(actual, low..high) do
    num = Enum.random(low..high)
    IO.puts "is it #{num}?"
    cond do
      num < actual -> guess(actual, num..high)
      num > actual -> guess(actual, low..num)
      num == actual -> num
    end
  end
end
