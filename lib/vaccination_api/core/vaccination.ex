defmodule VaccinationApi.Core.Vaccination do
  @moduledoc """
    Vaccination Entity
    ---
    Vaccination register
  """

  alias VaccinationApi.Core.{HealthCenter, HealthProfessional, Person, Vaccine}
  use VaccinationApi.Schema

  @shot_enum [:shot_1, :shot_2, :shot_3, :shot_4]
  @basic_fields [:id, :shot, :date, :token]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "vaccinations" do
      field :shot, Ecto.Enum,
        values: @shot_enum,
        __swagger__: [description: "vaccine shot", example: "shot_1", enum: @shot_enum]

      field :date, :utc_datetime,
        __swagger__: [description: "vaccination date", example: "2024-01-28T12:34:56.789Z"]

      field :token, :string, default: Ecto.UUID.generate()

      timestamps()

      belongs_to :person, Person
      belongs_to :health_professional, HealthProfessional
      belongs_to :health_center, HealthCenter
      belongs_to :vaccine, Vaccine
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_inclusion(:shot, @shot_enum)
    |> validate_required([:person_id, :health_center_id, :health_professional_id, :vaccine_id])
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Vaccination
    use Bee.Api
  end
end
