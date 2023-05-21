defmodule VaccinationApi.Repo do
  use Ecto.Repo,
    otp_app: :vaccination_api,
    adapter: Ecto.Adapters.Postgres
end
