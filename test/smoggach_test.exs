defmodule SmoggachTest do
  use ExUnit.Case
  doctest Smoggach

  test "greets the world" do
    assert Smoggach.hello() == :world
  end

  test "detects annagrams" do
    assert Smoggach.annagrams?("super", "perus") == true
  end

  test "throws error" do
    assert_raise FunctionClauseError, fn ->
      Smoggach.annagrams?(3, 5) == true
    end
  end

  test "fizzword results in FizzBuzz" do
    assert Smoggach.fizzword(0, 0, 1) == "FizzBuzz"
  end

  test "fizzword results in Fizz" do
    assert Smoggach.fizzword(0, 1, 1) == "Fizz"
  end

  test "fizzword results in Buzz" do
    assert Smoggach.fizzword(1, 0, 1) == "Buzz"
  end

  test "fizzword results in argument c" do
    assert Smoggach.fizzword(1, 1, 1) == 1
  end

  test "fizzbuzz results in [Buzz, 11, Fizz, 13, 14, FizzBuzz, 16]" do
    assert Smoggach.fizzbuzz() == ["Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16]
  end

  test "prefix prefixes name" do
    assert Smoggach.prefix("Mr.").("Elixir") == "Mr. Elixir"
  end

  test "sum recursively sums number from 1 to n" do
    assert Smoggach.sum(6) == 21
  end

  test "guess finds 273" do
    assert Smoggach.guess(273, 1..1000) == 273
  end

  test "mapsum runs function on each item and sums result" do
    assert Smoggach.mapsum([1, 2, 3], fn x -> x * x end) == 14
  end
end
