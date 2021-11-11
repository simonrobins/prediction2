defmodule Prediction2Web.PageController do
  use Prediction2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
