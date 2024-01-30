defmodule VaccinationApi.Repo.Migrations.CreateHealthProfessional do
  use Ecto.Migration

  def change do
    create table(:health_professionals) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :cpf, :string, null: false
      add :professional_register, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:health_professionals, [:professional_register])
    create unique_index(:health_professionals, [:cpf])
  end
end
