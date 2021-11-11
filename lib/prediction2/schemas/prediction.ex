defmodule Prediction2.Schemas.Prediction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Prediction2.Schemas.{Fixture, User}

  schema "predictions" do
    field :result, :string

    belongs_to :user, User
    belongs_to :fixture, Fixture
  end

  @doc false
  def changeset(prediction, attrs) do
    prediction
    |> cast(attrs, [:user_id, :fixture_id, :result])
    |> validate_required([:user_id, :fixture_id, :result])
  end
end
