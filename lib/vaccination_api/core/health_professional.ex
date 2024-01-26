defmodule VaccinationApi.Core.HealthProfessional do
  @moduledoc """
    HealthProfessional Entity
    ---
    User who applies vaccination to persons
  """

  alias VaccinationApi.Utils
  alias VaccinationApi.Core.{Vaccination}
  use VaccinationApi.Schema

  @fields [:first_name, :last_name, :cpf, :professional_register, :email, :__password__]

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

    def changeset(model \\ %__MODULE__{}, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_format(:email, ~r/@/)
    |> Utils.validate_cpf()
    |> unique_constraint(:cpf)
    |> Utils.put_password_hash()
  end

  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.HealthProfessional
    use Bee.Api

    def check_password(%{hashed_password: nil}, _password), do: false

    def check_password(%{hashed_password: hashed_password}, password) do
      Bcrypt.verify_pass(password, hashed_password)
    end
  end
end
