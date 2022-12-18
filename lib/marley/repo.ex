defmodule Marley.Repo do
  use Ecto.Repo,
    otp_app: :marley,
    adapter: Ecto.Adapters.Postgres
end
