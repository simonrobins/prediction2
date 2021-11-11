defmodule Prediction2Web.FixtureControllerTest do
  use Prediction2Web.ConnCase

  import Prediction2.SchemasFixtures

  @create_attrs %{away: "some away", date: ~D[2021-10-29], home: "some home"}
  @update_attrs %{away: "some updated away", date: ~D[2021-10-30], home: "some updated home"}
  @invalid_attrs %{away: nil, date: nil, home: nil}

  describe "index" do
    test "lists all fixtures", %{conn: conn} do
      conn = get(conn, Routes.fixture_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fixtures"
    end
  end

  describe "new fixture" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fixture_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fixture"
    end
  end

  describe "create fixture" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fixture_path(conn, :create), fixture: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fixture_path(conn, :show, id)

      conn = get(conn, Routes.fixture_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fixture"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fixture_path(conn, :create), fixture: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fixture"
    end
  end

  describe "edit fixture" do
    setup [:create_fixture]

    test "renders form for editing chosen fixture", %{conn: conn, fixture: fixture} do
      conn = get(conn, Routes.fixture_path(conn, :edit, fixture))
      assert html_response(conn, 200) =~ "Edit Fixture"
    end
  end

  describe "update fixture" do
    setup [:create_fixture]

    test "redirects when data is valid", %{conn: conn, fixture: fixture} do
      conn = put(conn, Routes.fixture_path(conn, :update, fixture), fixture: @update_attrs)
      assert redirected_to(conn) == Routes.fixture_path(conn, :show, fixture)

      conn = get(conn, Routes.fixture_path(conn, :show, fixture))
      assert html_response(conn, 200) =~ "some updated away"
    end

    test "renders errors when data is invalid", %{conn: conn, fixture: fixture} do
      conn = put(conn, Routes.fixture_path(conn, :update, fixture), fixture: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fixture"
    end
  end

  describe "delete fixture" do
    setup [:create_fixture]

    test "deletes chosen fixture", %{conn: conn, fixture: fixture} do
      conn = delete(conn, Routes.fixture_path(conn, :delete, fixture))
      assert redirected_to(conn) == Routes.fixture_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.fixture_path(conn, :show, fixture))
      end
    end
  end

  defp create_fixture(_) do
    fixture = fixture_fixture()
    %{fixture: fixture}
  end
end
