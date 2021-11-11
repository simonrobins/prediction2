defmodule Prediction2.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Prediction2.Schemas.Prediction

  schema "users" do
    field :initials, :string
    field :name, :string

    has_many :predictions, Prediction
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:initials, :name])
    |> validate_required([:initials, :name])
  end
end
