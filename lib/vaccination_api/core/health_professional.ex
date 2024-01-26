defmodule VaccinationApi.Core.HealthProfessional do
  @moduledoc """
    HealthProfessional Entity
    ---
    User who applies vaccination to persons
  """

  alias VaccinationApi.Utils
  alias VaccinationApi.Core.{Vaccination}
  use VaccinationApi.Schema

  generate_bee do
    schema "health_professional" do
      field :first_name, :string, bee: [required: true]
      field :last_name, :string, bee: [required: true]
      field :cpf, :string, bee: [required: true]
      field :professional_register, :string, bee: [required: true]
      field :email, :string, bee: [required: true]
      field :__password__, :string, virtual: true, redact: true
      field :hashed_password, :string, redact: true, bee: [required: true]

      timestamps()

      has_many :vaccination, Vaccination
    end
  end

  def changeset(model, attrs), do: changeset_(model, attrs, :insert)

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> Utils.validate_cpf()
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthProfessional
    use Bee.Api
  end
end
