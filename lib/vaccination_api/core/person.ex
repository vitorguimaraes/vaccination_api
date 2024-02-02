defmodule VaccinationApi.Core.Person do
  @moduledoc """
    Person Entity
    ---
    User who access vaccination platform as person who will take vaccine
  """

  alias VaccinationApi.Core.{User, Vaccination}
  use VaccinationApi.Schema

  @gender_enum [:male, :female]
  @basic_fields [:id, :first_name, :last_name, :birth, :cpf, :sus_number, :mother_name, :gender]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "persons" do
      field :first_name, :string
      field :last_name, :string
      field :birth, :date
      field :cpf, :string
      field :sus_number, :string
      field :mother_name, :string
      field :gender, Ecto.Enum, values: @gender_enum

      timestamps()

      has_many :vaccination, Vaccination
      belongs_to :user, User
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_required([
      :first_name,
      :last_name,
      :birth,
      :cpf,
      :sus_number,
      :mother_name,
      :gender
    ])
    |> validate_cpf()
    |> unique_constraint(:cpf)
    |> unique_constraint(:sus_number)
    |> validate_length(:sus_number, is: 15, message: "SUS number must have fifteen digits")
  end

  def changeset_update(model, attrs) do
    changeset_(model, attrs, :update)
    |> unique_constraint(:cpf)
    |> unique_constraint(:sus_number)
    |> validate_cpf()
    |> validate_length(:sus_number, is: 15, message: "SUS number must have fifteen digits")
  end

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

    @schema VaccinationApi.Core.Person
    use Bee.Api
  end
end
