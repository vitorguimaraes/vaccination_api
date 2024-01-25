defmodule VaccinationApi.Repo.Migrations.CreateVaccine do
  use Ecto.Migration

  def change do
    create table(:vaccine) do
      add :name, :string
      add :lot, :string
      add :expiration_date, :date

      timestamps()

    end
  end
end
