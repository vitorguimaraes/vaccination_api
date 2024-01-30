defmodule VaccinationApi.Repo.Migrations.CreateTableProfessionalWorksIn do
  use Ecto.Migration

  def change do
    create table(:professional_works_in, primary_key: false) do
      add :health_professional_id, references(:health_professionals, on_delete: :delete_all)
      add :health_center_id, references(:health_centers, on_delete: :delete_all)
    end

    create unique_index(:professional_works_in, [:health_professional_id, :health_center_id])
  end
end
