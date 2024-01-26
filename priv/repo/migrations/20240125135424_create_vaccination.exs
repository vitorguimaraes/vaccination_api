defmodule VaccinationApi.Repo.Migrations.CreateVaccination do
  use Ecto.Migration

  def change do
    create table(:vaccination) do
      add :shot, :string, null: false
      add :date, :utc_datetime, null: false
      add :token, :string

      add :person, references(:person, on_delete: :delete_all)
      add :health_professional, references(:health_professional, on_delete: :nothing)
      add :vaccine, references(:vaccine, on_delete: :nothing)

      timestamps()
    end
  end
end
