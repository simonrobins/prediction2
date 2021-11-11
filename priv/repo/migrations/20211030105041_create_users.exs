defmodule Prediction2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :initials, :string
      add :name, :string
    end
  end
end
