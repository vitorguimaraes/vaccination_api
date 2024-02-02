defmodule VaccinationApi.Core.User do
  @moduledoc """
    User Entity
  """

  alias VaccinationApi.Core.{HealthProfessional, Person}
  use VaccinationApi.Schema

  @basic_fields [:id, :username, :email, :is_admin?]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "users" do
      field :username, :string
      field :email, :string
      field :is_admin?, :boolean, default: false
      field :__password__, :string, virtual: true, redact: true
      field :hashed_password, :string, redact: true

      timestamps()

      has_one :person, Person
      has_one :health_professional, HealthProfessional
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_required([:username, :email, :__password__])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "invalid email format")
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def changeset_update(model, attrs) do
    changeset_(model, attrs, :update)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "invalid email format")
  end

  defp put_password_hash(%{changes: %{__password__: password}} = changeset) do
    if password && changeset.valid? do
      changeset
      |> validate_length(:__password__,
        min: 8,
        message: "Password must be at least eight characters"
      )
      |> validate_format(:__password__, ~r/[0-9]+/, message: "Password must contain a number")
      |> validate_format(:__password__, ~r/[A-Z]+/,
        message: "Password must contain an upper-case letter"
      )
      |> validate_format(:__password__, ~r/[a-z]+/,
        message: "Password must contain a lower-case letter"
      )
      |> validate_format(:__password__, ~r/[#\!\?&@\$%^&*\(\)]+|[!?@#$%^&*_]/,
        message: "Password must contain a symbol"
      )
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:__password__)
    else
      changeset
    end
  end

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.User
    use Bee.Api

    def check_password(%{hashed_password: nil}, _password), do: false

    def check_password(%{hashed_password: hashed_password}, password) do
      Bcrypt.verify_pass(password, hashed_password)
    end
  end
end
