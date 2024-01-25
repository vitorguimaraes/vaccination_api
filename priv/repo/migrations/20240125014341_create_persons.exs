defmodule VaccinationApi.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :first_name, :string
      add :last_name, :string
      add :birth, :date
      add :cpf, :string, required: true
      add :sus_number, :string, required: true
      add :mother_name, :string
      add :gender, :string
      add :email, :string, required: true
      add :password, :string

      timestamps()
    end
  end
end
