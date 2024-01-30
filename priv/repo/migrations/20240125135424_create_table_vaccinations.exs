defmodule VaccinationApi.Repo.Migrations.CreateVaccination do
  use Ecto.Migration

  def change do
    create table(:vaccinations) do
      add :shot, :string, null: false
      add :date, :utc_datetime, null: false
      add :token, :string

      add :person_id, references(:persons, on_delete: :delete_all)
      add :health_professional_id, references(:health_professionals, on_delete: :nothing)
      add :vaccine_id, references(:vaccines, on_delete: :nothing)

      timestamps()
    end
  end
end
