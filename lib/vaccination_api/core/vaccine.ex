defmodule VaccinationApi.Core.Vaccine do
  @moduledoc """
    Vaccine Entity
    ---
    Vaccine data
  """

  alias VaccinationApi.Core.{HealthCenter, Vaccination}
  use VaccinationApi.Schema

  @basic_fields [:id, :name, :lot, :expiration_date]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "vaccines" do
      field :name, :string, __swagger__: [description: "vaccine's name", example: "Pfizer"]

      field :lot, :string, __swagger__: [description: "vaccine's lot", example: "ABCXYZ123"]

      field :expiration_date, :date,
        __swagger__: [description: "vaccine's expiration date", example: "2024-05-12"]

      timestamps()

      has_many :vaccination, Vaccination
      many_to_many :health_center, HealthCenter, join_through: "health_center_vaccines"
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_required([:name, :lot, :expiration_date])
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Vaccine
    use Bee.Api
  end
end
