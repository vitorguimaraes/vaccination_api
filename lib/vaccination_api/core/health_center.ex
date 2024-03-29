defmodule VaccinationApi.Core.HealthCenter do
  @moduledoc """
    HealthCenter Entity
    ---
    Health Center where the vaccination happens
  """

  alias VaccinationApi.Core.{HealthProfessional, Vaccination, Vaccine}
  use VaccinationApi.Schema

  @basic_fields [:id, :name, :phone, :CNES]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "health_centers" do
      field :name, :string,
        __swagger__: [description: "health center's name", example: "Unidade Básica de Saúde"]

      field :phone, :string,
        __swagger__: [description: "health center's phone", example: "85993782314"]

      field :CNES, :string,
        __swagger__: [description: "health center's CNES", example: "123543513"]

      timestamps()

      has_many :vaccination, Vaccination
      many_to_many :health_professional, HealthProfessional, join_through: "professional_works_in"
      many_to_many :vaccine, Vaccine, join_through: "health_center_vaccines"
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_required([:name, :phone, :CNES])
    |> unique_constraint(:CNES)
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthCenter
    use Bee.Api
  end
end
