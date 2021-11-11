defmodule Prediction2.SchemasTest do
  use Prediction2.DataCase

  alias Prediction2.Schemas

  describe "users" do
    alias Prediction2.Schemas.User

    import Prediction2.SchemasFixtures

    @invalid_attrs %{initials: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Schemas.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Schemas.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{initials: "some initials", name: "some name"}

      assert {:ok, %User{} = user} = Schemas.create_user(valid_attrs)
      assert user.initials == "some initials"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemas.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{initials: "some updated initials", name: "some updated name"}

      assert {:ok, %User{} = user} = Schemas.update_user(user, update_attrs)
      assert user.initials == "some updated initials"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemas.update_user(user, @invalid_attrs)
      assert user == Schemas.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Schemas.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Schemas.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Schemas.change_user(user)
    end
  end

  describe "teams" do
    alias Prediction2.Schemas.Team

    import Prediction2.SchemasFixtures

    @invalid_attrs %{name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Schemas.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Schemas.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Team{} = team} = Schemas.create_team(valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemas.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Team{} = team} = Schemas.update_team(team, update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemas.update_team(team, @invalid_attrs)
      assert team == Schemas.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Schemas.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Schemas.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Schemas.change_team(team)
    end
  end

  describe "fixtures" do
    alias Prediction2.Schemas.Fixture

    import Prediction2.SchemasFixtures

    @invalid_attrs %{away: nil, date: nil, home: nil}

    test "list_fixtures/0 returns all fixtures" do
      fixture = fixture_fixture()
      assert Schemas.list_fixtures() == [fixture]
    end

    test "get_fixture!/1 returns the fixture with given id" do
      fixture = fixture_fixture()
      assert Schemas.get_fixture!(fixture.id) == fixture
    end

    test "create_fixture/1 with valid data creates a fixture" do
      valid_attrs = %{away: "some away", date: ~D[2021-10-29], home: "some home"}

      assert {:ok, %Fixture{} = fixture} = Schemas.create_fixture(valid_attrs)
      assert fixture.away == "some away"
      assert fixture.date == ~D[2021-10-29]
      assert fixture.home == "some home"
    end

    test "create_fixture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemas.create_fixture(@invalid_attrs)
    end

    test "update_fixture/2 with valid data updates the fixture" do
      fixture = fixture_fixture()
      update_attrs = %{away: "some updated away", date: ~D[2021-10-30], home: "some updated home"}

      assert {:ok, %Fixture{} = fixture} = Schemas.update_fixture(fixture, update_attrs)
      assert fixture.away == "some updated away"
      assert fixture.date == ~D[2021-10-30]
      assert fixture.home == "some updated home"
    end

    test "update_fixture/2 with invalid data returns error changeset" do
      fixture = fixture_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemas.update_fixture(fixture, @invalid_attrs)
      assert fixture == Schemas.get_fixture!(fixture.id)
    end

    test "delete_fixture/1 deletes the fixture" do
      fixture = fixture_fixture()
      assert {:ok, %Fixture{}} = Schemas.delete_fixture(fixture)
      assert_raise Ecto.NoResultsError, fn -> Schemas.get_fixture!(fixture.id) end
    end

    test "change_fixture/1 returns a fixture changeset" do
      fixture = fixture_fixture()
      assert %Ecto.Changeset{} = Schemas.change_fixture(fixture)
    end
  end

  describe "predictions" do
    alias Prediction2.Schemas.Prediction

    import Prediction2.SchemasFixtures

    @invalid_attrs %{result: nil}

    test "list_predictions/0 returns all predictions" do
      prediction = prediction_fixture()
      assert Schemas.list_predictions() == [prediction]
    end

    test "get_prediction!/1 returns the prediction with given id" do
      prediction = prediction_fixture()
      assert Schemas.get_prediction!(prediction.id) == prediction
    end

    test "create_prediction/1 with valid data creates a prediction" do
      valid_attrs = %{result: "some result"}

      assert {:ok, %Prediction{} = prediction} = Schemas.create_prediction(valid_attrs)
      assert prediction.result == "some result"
    end

    test "create_prediction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemas.create_prediction(@invalid_attrs)
    end

    test "update_prediction/2 with valid data updates the prediction" do
      prediction = prediction_fixture()
      update_attrs = %{result: "some updated result"}

      assert {:ok, %Prediction{} = prediction} =
               Schemas.update_prediction(prediction, update_attrs)

      assert prediction.result == "some updated result"
    end

    test "update_prediction/2 with invalid data returns error changeset" do
      prediction = prediction_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemas.update_prediction(prediction, @invalid_attrs)
      assert prediction == Schemas.get_prediction!(prediction.id)
    end

    test "delete_prediction/1 deletes the prediction" do
      prediction = prediction_fixture()
      assert {:ok, %Prediction{}} = Schemas.delete_prediction(prediction)
      assert_raise Ecto.NoResultsError, fn -> Schemas.get_prediction!(prediction.id) end
    end

    test "change_prediction/1 returns a prediction changeset" do
      prediction = prediction_fixture()
      assert %Ecto.Changeset{} = Schemas.change_prediction(prediction)
    end
  end
end
