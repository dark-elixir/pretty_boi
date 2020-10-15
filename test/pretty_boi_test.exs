defmodule PrettyBoiTest do
  use ExUnit.Case
  doctest PrettyBoi

  test "greets the world" do
    assert PrettyBoi.hello() == :world
  end
end
