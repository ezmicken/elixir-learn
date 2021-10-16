defmodule ChatTest do
  use ExUnit.Case, async: true
  doctest Smoggach

  @tag :distributed
  test "send_message" do
    assert Smoggach.send_message(:sam@localhost, "hi") == :ok
  end
end
