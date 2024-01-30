defmodule VaccinationApi.Repo.Migrations.CreateTableHealthCenters do
  use Ecto.Migration

  def change do
    create table(:health_centers) do
      add :name, :string, null: false
      add :phone, :string, null: false
      add :CNES, :string, null: false

      timestamps()
    end

    create unique_index(:health_centers, [:CNES])
  end
end
