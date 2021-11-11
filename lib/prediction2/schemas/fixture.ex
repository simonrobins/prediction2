defmodule Prediction2.Schemas.Fixture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fixtures" do
    field :date, :date
    field :result, :string

    field :home, :string
    field :away, :string
  end

  @doc false
  def changeset(fixture, attrs) do
    fixture
    |> cast(attrs, [:date, :home, :away])
    |> validate_required([:date, :home, :away])
  end

  @doc false
  def resultChangeset(fixture, attrs) do
    fixture
    |> cast(attrs, [:result])
    |> validate_required([:result])
  end
end
