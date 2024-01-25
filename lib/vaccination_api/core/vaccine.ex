defmodule VaccinationApi.Core.Vaccine do
  @moduledoc """
    Vaccine Entity
    ---
    Vaccine data
  """

  alias VaccinationApi.Core.{Vaccination}
  use VaccinationApi.Schema

  generate_bee do
    schema "vaccine" do
      field :name, :string
      field :lot, :string
      field :expiration_date, :date

      timestamps()

      has_many :vaccination, Vaccination
    end
  end

  def changeset(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Vaccination
    use Bee.Api
  end
end
