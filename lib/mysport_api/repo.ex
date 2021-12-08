defmodule MysportApi.Repo do
  use Ecto.Repo,
    otp_app: :mysport_api,
    adapter: Ecto.Adapters.Postgres
end
