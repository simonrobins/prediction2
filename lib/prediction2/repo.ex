defmodule Prediction2.Repo do
  use Ecto.Repo,
    otp_app: :prediction2,
    adapter: Ecto.Adapters.Postgres
end
