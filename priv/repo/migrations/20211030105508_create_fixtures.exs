defmodule Prediction2.Repo.Migrations.CreateFixtures do
  use Ecto.Migration

  def change do
    create table(:fixtures) do
      add :date, :date
      add :home, :string
      add :away, :string
      add :result, :string
    end
  end
end
