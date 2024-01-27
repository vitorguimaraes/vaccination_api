defmodule VaccinationApi.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :birth, :date, null: false
      add :cpf, :string, null: false
      add :sus_number, :string, null: false
      add :mother_name, :string, null: false
      add :gender, :string, null: false
      add :email, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create unique_index(:person, [:cpf])
    create unique_index(:person, [:sus_number])
    create unique_index(:person, [:email])
  end
end
