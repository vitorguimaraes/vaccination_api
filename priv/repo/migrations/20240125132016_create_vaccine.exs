defmodule VaccinationApi.Repo.Migrations.CreateVaccine do
  use Ecto.Migration

  def change do
    create table(:vaccine) do
      add :name, :string, null: false
      add :lot, :string, null: false
      add :expiration_date, :date, null: false

      timestamps()

    end
  end
end
