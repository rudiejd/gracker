defmodule Gracker.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :address, :string

      timestamps(type: :utc_datetime)
    end
  end
end
