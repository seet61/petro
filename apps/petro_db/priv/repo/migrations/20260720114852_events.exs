defmodule PetroDB.Repo.Migrations.Events do
  use Ecto.Migration

  def change do
    # table
    create table("events") do
      add :name, :string, null: false
      add :body, :string
      add :priority, :integer, default: 0

      timestamps()
    end

    # index
    create unique_index("events", [:name])
  end
end
