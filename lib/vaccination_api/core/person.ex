defmodule VaccinationApi.Core.Person do
  @moduledoc """
    Person Entity
    ---
    User Person to access vaccination platform as person who will take vaccine
  """

  alias VaccinationApi.Core.Vaccination
  use VaccinationApi.Schema

  @gender_enum [:male, :female]
  @basic_fields [:id, :first_name, :last_name, :birth, :cpf, :sus_number, :mother_name, :gender, :email]

  generate_bee do
    permission(:basic, @basic_fields)

    schema "person" do
      field :first_name, :string, bee: [required: true]
      field :last_name, :string, bee: [required: true]
      field :birth, :date, bee: [required: true]
      field :cpf, :string, bee: [required: true]
      field :sus_number, :string, bee: [required: true]
      field :mother_name, :string, bee: [required: true]
      field :gender, Ecto.Enum, values: @gender_enum, bee: [required: true]
      field :email, :string, bee: [required: true]
      field :__password__, :string, virtual: true, redact: true, bee: [required: true]
      field :hashed_password, :string, redact: true

      timestamps()

      has_many :vaccination, Vaccination
    end
  end

  def changeset_insert(model, attrs) do
    changeset_(model, attrs, :insert)
    |> validate_format(:email, ~r/@/, message: "invalid email format")
    |> validate_cpf()
    |> unique_constraint(:cpf)
    |> unique_constraint(:sus_number)
    |> unique_constraint(:email)
    |> validate_length(:sus_number, is: 15, message: "SUS number must have fifteen digits")
    |> put_password_hash()
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defp validate_cpf(%{changes: %{cpf: cpf}} = changeset) do
    cond do
      Brcpfcnpj.cpf_valid?(cpf) == false ->
        Ecto.Changeset.add_error(changeset, :cpf, "cpf is invalid")

      :else ->
        changeset
    end
  end

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

    def check_password(%{hashed_password: nil}, _password), do: false

    def check_password(%{hashed_password: hashed_password}, password) do
      Bcrypt.verify_pass(password, hashed_password)
    end
  end
end
