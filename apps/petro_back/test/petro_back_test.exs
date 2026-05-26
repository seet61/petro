defmodule PetroBackTest do
  use ExUnit.Case
  doctest PetroBack

  test "greets the world" do
    assert PetroBack.hello() == :world
  end
end
