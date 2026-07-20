defmodule PetroDB.RepoTest do
  use ExUnit.Case, async: false
  require Logger
  alias PetroDB.Schemas.Event
  alias PetroDB.Repo

  test "проверка полей в схеме" do
    # Assert fields exist
    assert :name in Event.__schema__(:fields)
    assert :body in Event.__schema__(:fields)
    assert :priority in Event.__schema__(:fields)

    # Assert field types match database mapping
    assert Event.__schema__(:type, :name) == :string
    assert Event.__schema__(:type, :body) == :string
    assert Event.__schema__(:type, :priority) == :integer
  end

  test "schema has correct database table source" do
    assert Event.__schema__(:source) == "events"
  end

  test "init check" do
    IO.puts("init check db test")

    event = %Event{
      name: "test11",
      body: "test body event",
      priority: 1
    }
    Logger.info(inspect(event))
    assert is_nil(event.id)
  
    event = Repo.insert!(event)
    assert 1 = event.id
    
    Logger.info(event)
    Repo.delete!(event)
  end

  test "changeset ok" do
    IO.puts("changeset ok")
    map = %{"name" => "test123", "body" => "test body event", "priority" => 1}
    changeset = PetroDB.Schemas.Event.changeset(map)
    Logger.info(changeset)
  end

  test "changeset error" do
    IO.puts("changeset error")
    map = %{"name" => "test", "body" => "test", "priority" => -1}
    changeset = PetroDB.Schemas.Event.changeset(map)
    Logger.info(changeset)
    assert nil != changeset.errors 
  end
end
