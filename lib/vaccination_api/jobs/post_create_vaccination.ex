defmodule VaccinationApi.Jobs.RegisterVaccination do
  @moduledoc """
  Create vaccination
  """

  alias VaccinationApi.Core.Vaccination
  use Oban.Worker

  def perform(%Job{args: params}) do
    {:ok, vaccination} = Vaccination.Api.insert(params)
  end

  def create_worker(params) do
    params
    |> __MODULE__.new()
    |> Oban.insert()
  end

  def create_worker(params, opts) do
    params
    |> __MODULE__.new(opts)
    |> Oban.insert()
  end
end
