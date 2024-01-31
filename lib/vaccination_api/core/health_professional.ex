defmodule VaccinationApi.Core.HealthProfessional do
  @moduledoc """
    HealthProfessional Entity
    ---
    User who applies vaccination to persons
  """

  alias VaccinationApi.Core.{HealthCenter, User, Vaccination}
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

      belongs_to :user, User
      has_many :vaccination, Vaccination
      many_to_many :health_center, HealthCenter, join_through: "professional_works_in"
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
    if Brcpfcnpj.cpf_valid?(cpf) do
      changeset
    else
      Ecto.Changeset.add_error(changeset, :cpf, "cpf is invalid")
    end
  end

  defp validate_cpf(%{changes: %{}} = changeset), do: changeset

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthProfessional
    use Bee.Api
  end
end
