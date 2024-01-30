defmodule VaccinationApi.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :birth, :date, null: false
      add :cpf, :string, null: false
      add :sus_number, :string, null: false
      add :mother_name, :string, null: false
      add :gender, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:persons, [:cpf])
    create unique_index(:persons, [:sus_number])
  end
end
