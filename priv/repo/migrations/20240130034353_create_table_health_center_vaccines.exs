defmodule VaccinationApi.Repo.Migrations.CreateTableHealthCenterVaccines do
  use Ecto.Migration

  def change do
    create table(:health_center_vaccines, primary_key: false) do
      add :stock_quantity, :integer, default: 0

      add :health_center_id, references(:health_centers, on_delete: :delete_all)
      add :vaccine_id, references(:vaccines, on_delete: :delete_all)
    end

    create unique_index(:health_center_vaccines, [:health_center_id, :vaccine_id])
  end
end
