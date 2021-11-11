defmodule Prediction2Web.PredictionController do
  use Prediction2Web, :controller

  alias Prediction2.Schemas

  @paginate_by 10

  def select(conn, %{"user" => user_id, "fixture" => fixture_id, "result" => result}) do
    prediction = Schemas.get_prediction_by_user_fixture(user_id, fixture_id)
    if prediction do
      Schemas.update_prediction(prediction, %{result: result})
    else
      Schemas.create_prediction(%{user_id: user_id, fixture_id: fixture_id, result: result})
    end
    send_resp(conn, 200, "")
  end

  def landing(conn, params) do
    params = Map.put(params, "page", "1")
    index(conn, params)
  end

  def index(conn, %{"user_id" => user_id, "page" => page}) do
    user_id = String.to_integer(user_id)
    page = String.to_integer(page)

    user = Schemas.get_user!(user_id)
    current_score = Schemas.get_current_score(user_id)
    IO.inspect(current_score)

    fixtures = Schemas.get_fixtures_and_predictions_paginated(user_id, page, @paginate_by)
    paginator = EctoPaginator.paginate_helper(page, @paginate_by, Schemas.count_fixtures())

    render(conn, "index.html", fixtures: fixtures, user: user, paginator: paginator, current_score: current_score)
  end
end
