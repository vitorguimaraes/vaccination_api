defmodule VaccinationApi.Core.HealthProfessional do
  @moduledoc """
    HealthProfessional Entity
    ---
    User who applies vaccination to persons
  """

  alias VaccinationApi.Core.{User, Vaccination}
  use VaccinationApi.Schema

  @basic_fields [:id, :first_name, :last_name, :cpf, :professional_register]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "health_professionals" do
      field :first_name, :string
      field :last_name, :string
      field :cpf, :string
      field :professional_register, :string

      timestamps()

      has_many :vaccination, Vaccination
      belongs_to :user, User
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_required([:first_name, :last_name, :cpf, :professional_register])
    |> validate_cpf()
    |> unique_constraint(:cpf)
    |> unique_constraint(:professional_register)
  end

  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defp validate_cpf(%{changes: %{cpf: cpf}} = changeset) do
    cond do
      Brcpfcnpj.cpf_valid?(cpf) == false ->
        Ecto.Changeset.add_error(changeset, :cpf, "cpf is invalid")

      :else ->
        changeset
    end
  end

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthProfessional
    use Bee.Api
  end
end
