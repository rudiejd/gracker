defmodule Gracker.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :upc, :string

      timestamps(type: :utc_datetime)
    end
  end
end
