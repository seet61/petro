defmodule PetroDB.Schemas.Event do
  alias PetroDB.Schemas.Event
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "petro"

  schema "events" do
    field(:name, :string)
    field(:body, :string)
    field(:priority, :integer, default: 0)
    timestamps()
  end

  def changeset(params) do
    %Event{}
    |> cast(params, [:name, :body, :priority])
    |> validate_required([:name, :body])
    |> validate_length(:name, min: 5)
    |> validate_length(:body, min: 10)
    #|> validate_inclusion(:priority, min: 0)
  end
	
end
