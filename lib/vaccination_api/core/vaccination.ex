defmodule VaccinationApi.Core.Vaccination do
  @moduledoc """
    Vaccination Entity
    ---
    Vaccination register
  """

  alias VaccinationApi.Core.{HealthProfessional, Person, Vaccine}
  use VaccinationApi.Schema

  @shot_enum [:shot_1, :shot_2, :shot_3, :shot_4]
  @basic_fields [:id, :shot, :date, :token]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "vaccinations" do
      field :shot, Ecto.Enum, values: @shot_enum
      field :date, :utc_datetime
      field :token, :string, default: Ecto.UUID.generate()

      timestamps()

      belongs_to :person, Person
      belongs_to :health_professional, HealthProfessional
      belongs_to :vaccine, Vaccine
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_inclusion(:shot, @shot_enum)
    |> cast_assoc(:person)
    |> cast_assoc(:health_professional)
    |> cast_assoc(:vaccine)
    |> validate_required([:person, :health_professional, :vaccine])
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Vaccination
    use Bee.Api
  end
end
