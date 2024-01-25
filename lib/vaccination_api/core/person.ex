defmodule VaccinationApi.Core.Person do
  @moduledoc """
    Person Entity
    ---
    User Person to access platform
  """

  use VaccinationApi.Schema

  generate_bee do
    schema "person" do
      field :first_name, :string
      field :last_name, :string
      field :birth, :date
      field :cpf, :string, bee: [required: true]
      field :sus_number, :string, bee: [required: true]
      field :mother_name, :string
      field :gender, :string
      field :email, :string, bee: [required: true]
      field :password, :string

      timestamps()
    end
  end

  def changeset(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_insert(model, attrs), do: changeset_(model, attrs, :insert)
  def changeset_update(model, attrs), do: changeset_(model, attrs, :update)

  defmodule Api do
    @moduledoc false

    @schema VaccinationApi.Core.Person
    use Bee.Api
  end
end
