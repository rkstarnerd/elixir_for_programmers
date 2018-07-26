defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "greets the world" do
    assert Computer.hello() == :world
  end
end
