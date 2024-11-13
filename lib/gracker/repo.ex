defmodule Gracker.Repo do
  use Ecto.Repo,
    otp_app: :gracker,
    adapter: Ecto.Adapters.Postgres
end
