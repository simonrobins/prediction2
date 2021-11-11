defmodule Prediction2Web.PredictionControllerTest do
  use Prediction2Web.ConnCase

  import Prediction2.SchemasFixtures

  @create_attrs %{result: "some result"}
  @update_attrs %{result: "some updated result"}
  @invalid_attrs %{result: nil}

  describe "index" do
    test "lists all predictions", %{conn: conn} do
      conn = get(conn, Routes.prediction_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Predictions"
    end
  end

  describe "new prediction" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.prediction_path(conn, :new))
      assert html_response(conn, 200) =~ "New Prediction"
    end
  end

  describe "create prediction" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prediction_path(conn, :create), prediction: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.prediction_path(conn, :show, id)

      conn = get(conn, Routes.prediction_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Prediction"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prediction_path(conn, :create), prediction: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prediction"
    end
  end

  describe "edit prediction" do
    setup [:create_prediction]

    test "renders form for editing chosen prediction", %{conn: conn, prediction: prediction} do
      conn = get(conn, Routes.prediction_path(conn, :edit, prediction))
      assert html_response(conn, 200) =~ "Edit Prediction"
    end
  end

  describe "update prediction" do
    setup [:create_prediction]

    test "redirects when data is valid", %{conn: conn, prediction: prediction} do
      conn =
        put(conn, Routes.prediction_path(conn, :update, prediction), prediction: @update_attrs)

      assert redirected_to(conn) == Routes.prediction_path(conn, :show, prediction)

      conn = get(conn, Routes.prediction_path(conn, :show, prediction))
      assert html_response(conn, 200) =~ "some updated result"
    end

    test "renders errors when data is invalid", %{conn: conn, prediction: prediction} do
      conn =
        put(conn, Routes.prediction_path(conn, :update, prediction), prediction: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Prediction"
    end
  end

  describe "delete prediction" do
    setup [:create_prediction]

    test "deletes chosen prediction", %{conn: conn, prediction: prediction} do
      conn = delete(conn, Routes.prediction_path(conn, :delete, prediction))
      assert redirected_to(conn) == Routes.prediction_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.prediction_path(conn, :show, prediction))
      end
    end
  end

  defp create_prediction(_) do
    prediction = prediction_fixture()
    %{prediction: prediction}
  end
end
