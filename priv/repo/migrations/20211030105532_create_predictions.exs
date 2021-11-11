defmodule Prediction2.Repo.Migrations.CreatePredictions do
  use Ecto.Migration

  def change do
    create table(:predictions) do
      add :result, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :fixture_id, references(:fixtures, on_delete: :delete_all)
    end

    create index(:predictions, [:user_id])
  end
end
