defmodule VaccinationApi.Core.Person do
  @moduledoc """
    Person Entity
    ---
    User Person to access vaccination platform
  """

  alias VaccinationApi.Utils
  alias VaccinationApi.Core.{Vaccination}
  use VaccinationApi.Schema

  @gender_enum [:male, :female]
  @fields [:first_name, :last_name, :birth, :cpf, :sus_number, :mother_name, :gender, :email, :__password__]

  generate_bee do
    schema "person" do
      field :first_name, :string
      field :last_name, :string
      field :birth, :date
      field :cpf, :string, bee: [required: true]
      field :sus_number, :string, bee: [required: true]
      field :mother_name, :string
      field :gender, Ecto.Enum, values: @gender_enum
      field :email, :string, bee: [required: true]
      field :__password__, :string, virtual: true, redact: true
      field :hashed_password, :string, redact: true

      timestamps()

      has_many :vaccination, Vaccination
    end
  end

  def changeset(model \\ %__MODULE__{}, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_format(:email, ~r/@/)
    |> Utils.validate_cpf()
    |> unique_constraint(:cpf)
    |> unique_constraint(:sus_number)
    |> validate_length(:sus_number, is: 15, message: "SUS number must be fifteen digits")
    |> put_password_hash()
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defp put_password_hash(%{changes: %{__password__: password}} = changeset) do
    if password && changeset.valid? do
      changeset
      |> validate_length(:__password__, min: 8, message: "Password must be at least eight characters")
      |> validate_format(:__password__, ~r/[0-9]+/, message: "Password must contain a number")
      |> validate_format(:__password__, ~r/[A-Z]+/, message: "Password must contain an upper-case letter")
      |> validate_format(:__password__, ~r/[a-z]+/, message: "Password must contain a lower-case letter")
      |> validate_format(:__password__, ~r/[#\!\?&@\$%^&*\(\)]+/, message: "Password must contain a symbol")
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:__password__)
    else
      changeset
    end
  end

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Person
    use Bee.Api
  end
end
