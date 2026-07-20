defmodule PetroDbTest do
  use ExUnit.Case
  doctest PetroDb

  test "greets the world" do
    assert PetroDb.hello() == :world
  end
end
