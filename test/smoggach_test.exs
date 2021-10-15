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
end
