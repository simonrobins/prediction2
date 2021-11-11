defmodule Prediction2Web.FixtureController do
  use Prediction2Web, :controller

  alias Prediction2.Schemas

  @paginate_by 10

  def select(conn, %{"fixture" => fixture_id, "result" => result}) do
    fixture = Schemas.get_fixture!(fixture_id)
    ok = Schemas.update_fixture_result(fixture, result)
    IO.inspect(ok)
    send_resp(conn, 200, "")
  end

  def landing(conn, _params) do
    index(conn, %{"page" => "1"})
  end

  def index(conn, %{"page" => page} = _params) do
    page = String.to_integer(page)

    fixtures = Schemas.list_fixtures_with_pagination(page, @paginate_by)
    paginator = EctoPaginator.paginate_helper(page, @paginate_by, Schemas.count_fixtures())

    render(conn, "index.html", fixtures: fixtures, paginator: paginator)
  end
end
