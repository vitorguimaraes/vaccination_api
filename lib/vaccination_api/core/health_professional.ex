defmodule VaccinationApi.Core.HealthProfessional do
  @moduledoc """
    HealthProfessional Entity
    ---
    User who applies vaccination to persons
  """

  use VaccinationApi.Schema

  generate_bee do
    schema "health_professional" do
      field :first_name, :string
      field :last_name, :string
      field :professional_register, :string, bee: [required: true]
      field :cpf, :string, bee: [required: true]

      timestamps()
    end
  end

  def changeset(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthProfessional
    use Bee.Api
  end
end
