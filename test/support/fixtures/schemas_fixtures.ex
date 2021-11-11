defmodule Prediction2.SchemasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Prediction2.Schemas` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        initials: "some initials",
        name: "some name"
      })
      |> Prediction2.Schemas.create_user()

    user
  end

  @doc """
  Generate a fixture.
  """
  def fixture_fixture(attrs \\ %{}) do
    {:ok, fixture} =
      attrs
      |> Enum.into(%{
        away: "some away",
        date: ~D[2021-10-29],
        home: "some home"
      })
      |> Prediction2.Schemas.create_fixture()

    fixture
  end

  @doc """
  Generate a prediction.
  """
  def prediction_fixture(attrs \\ %{}) do
    {:ok, prediction} =
      attrs
      |> Enum.into(%{
        result: "some result"
      })
      |> Prediction2.Schemas.create_prediction()

    prediction
  end
end
