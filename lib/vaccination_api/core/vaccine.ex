defmodule VaccinationApi.Core.Vaccine do
  @moduledoc """
    Vaccine Entity
    ---
    Vaccine data
  """

  alias VaccinationApi.Core.{Vaccination}
  use VaccinationApi.Schema

  @basic_fields [:id, :name, :lot, :expiration_date]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "vaccine" do
      field :name, :string, bee: [required: true]
      field :lot, :string, bee: [required: true]
      field :expiration_date, :date, bee: [required: true]

      timestamps()

      has_many :vaccination, Vaccination
    end
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Vaccine
    use Bee.Api
  end
end
