defmodule VaccinationApi.Repo.Migrations.CreateVaccination do
  use Ecto.Migration

  def change do
    create table(:vaccination) do
      add :shot, :string
      add :date, :utc_datetime
      add :token, :string

      timestamps()
    end
  end
end
