defmodule VaccinationApi.Core.HealthCenterVaccines do
  @moduledoc """
    Associates Health Professional with Vaccines
  """

  alias VaccinationApi.Core.{HealthCenter, Vaccine}
  use VaccinationApi.Schema

  generate_bee do
    schema "health_center_vaccines" do
      field :stock_quantity, :integer, default: 0

      belongs_to :health_center, HealthCenter
      belongs_to :vaccine, Vaccine
    end
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthCenterVaccines
    use Bee.Api
    alias VaccinationApi.Core.HealthCenterVaccines
    alias VaccinationApi.Repo

    def assoc_activities(params) do
      %HealthCenterVaccines{}
      |> HealthCenterVaccines.changeset_insert(params)
      |> Repo.insert(on_conflict: :delete)
    end
  end
end
