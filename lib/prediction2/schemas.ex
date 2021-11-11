defmodule Prediction2.Schemas do
  @moduledoc """
  The Schemas context.
  """

  import Ecto.Query, warn: false
  require EctoPaginator

  alias Prediction2.Repo

  alias Prediction2.Schemas.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    users = Repo.all(User)
    users = Repo.preload(users, predictions: [:fixture, :user])
    IO.inspect(users)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    user = Repo.get!(User, id)
    user = Repo.preload(user, predictions: [:fixture, :user])
    IO.inspect(user)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Prediction2.Schemas.Fixture

  def count_fixtures() do
    Repo.aggregate(Fixture, :count)
  end

  @doc """
  Returns the list of fixtures.

  ## Examples

      iex> list_fixtures()
      [%Fixture{}, ...]

  """
  def list_fixtures do
    query = get_fixtures_query()
    Repo.all(query)
  end

  def list_fixtures_with_pagination(page_number, paginate_by) do
    get_fixtures_query()
    |> EctoPaginator.paginate(page_number, paginate_by)
    |> Repo.all()
  end

  defp get_fixtures_query do
    from f in Prediction2.Schemas.Fixture, order_by: [f.date, f.home, f.away]
  end

  @doc """
  Gets a single fixture.

  Raises `Ecto.NoResultsError` if the Fixture does not exist.

  ## Examples

      iex> get_fixture!(123)
      %Fixture{}

      iex> get_fixture!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fixture!(id) do
    Repo.get!(Fixture, id)
  end

  def update_fixture_result(%Fixture{} = fixture, result) do
    fixture
    |> Fixture.resultChangeset(%{result: result})
    |> Repo.update()
  end

  def create_fixture(attrs \\ %{}) do
    %Fixture{}
    |> Fixture.changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fixture changes.

  ## Examples

      iex> change_fixture(fixture)
      %Ecto.Changeset{data: %Fixture{}}

  """
  def change_fixture(%Fixture{} = fixture, attrs \\ %{}) do
    Fixture.changeset(fixture, attrs)
  end

  alias Prediction2.Schemas.Prediction

  @doc """
  Returns the list of predictions.

  ## Examples

      iex> list_predictions()
      [%Prediction{}, ...]

  """
  def list_predictions(user_id) do
    user = Repo.get(User, user_id)
    user = Repo.preload(user, predictions: [:fixture, :user])
    user.predictions
  end

  @doc """
  Gets a single prediction.

  Raises `Ecto.NoResultsError` if the Prediction does not exist.

  ## Examples

      iex> get_prediction!(123)
      %Prediction{}

      iex> get_prediction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prediction!(id) do
    prediction = Repo.get!(Prediction, id)
    Repo.preload(prediction, [:user, :fixture])
  end

  def get_prediction_by_user_fixture(user_id, fixture_id) do
    Repo.get_by(Prediction, [user_id: user_id, fixture_id: fixture_id])
  end

  def get_fixtures_and_predictions_paginated(user_id, page_number, paginate_by) do
    get_fixtures_and_predictions_query(user_id)
    |> EctoPaginator.paginate(page_number, paginate_by)
    |> Repo.all()
  end

  def get_fixtures_and_predictions_for_user(user_id) do
    get_fixtures_and_predictions_query(user_id)
    |> Repo.all()
  end

  defp get_fixtures_and_predictions_query(user_id) do
    Ecto.Query.from f in "fixtures",
      left_join: p in "predictions",
      on: f.id == p.fixture_id and p.user_id == ^user_id,
      order_by: [f.date, f.home, f.away],
      select: %{fixture_id: f.id, date: f.date, home: f.home, away: f.away, result: f.result, prediction_id: p.id, prediction: p.result}
  end

  def get_current_score(user_id) do
    query = Ecto.Query.from f in "fixtures",
      left_join: p in "predictions",
      on: f.id == p.fixture_id and p.user_id == ^user_id,
      where: f.result == p.result or (f.result == "H" and is_nil(p.result)),
      select: count(f.id)
    Repo.one(query)
  end

  @spec create_prediction(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  @doc """
  Creates a prediction.

  ## Examples

      iex> create_prediction(%{field: value})
      {:ok, %Prediction{}}

      iex> create_prediction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prediction(attrs \\ %{}) do
    %Prediction{}
    |> Prediction.changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
  end

  @doc """
  Updates a prediction.

  ## Examples

      iex> update_prediction(prediction, %{field: new_value})
      {:ok, %Prediction{}}

      iex> update_prediction(prediction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prediction(%Prediction{} = prediction, attrs) do
    prediction
    |> Prediction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prediction.

  ## Examples

      iex> delete_prediction(prediction)
      {:ok, %Prediction{}}

      iex> delete_prediction(prediction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prediction(%Prediction{} = prediction) do
    Repo.delete(prediction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prediction changes.

  ## Examples

      iex> change_prediction(prediction)
      %Ecto.Changeset{data: %Prediction{}}

  """
  def change_prediction(%Prediction{} = prediction, attrs \\ %{}) do
    Prediction.changeset(prediction, attrs)
  end
end
