defmodule PetroAmqpTest do
  use ExUnit.Case
  doctest PetroAmqp

  test "greets the world" do
    assert PetroAmqp.hello() == :world
  end
end
