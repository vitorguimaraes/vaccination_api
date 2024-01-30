defmodule VaccinationApi.Core.ProfessionalWorksIn do
  @moduledoc """
    Associates Health Professional with Health Center
  """

  alias VaccinationApi.Core.{HealthCenter, HealthProfessional}
  use VaccinationApi.Schema

  generate_bee do
    schema "professional_works_in" do
      belongs_to :health_professional, HealthProfessional
      belongs_to :health_center, HealthCenter
    end
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.ProfessionalWorksIn
    use Bee.Api
    alias VaccinationApi.Core.ProfessionalWorksIn
    alias VaccinationApi.Repo

    def assoc_activities(params) do
      %ProfessionalWorksIn{}
      |> ProfessionalWorksIn.changeset_insert(params)
      |> Repo.insert(on_conflict: :nothing)
    end
  end
end
