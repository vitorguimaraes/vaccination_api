defmodule VaccinationApi.Repo.Migrations.AlterVaccination do
  use Ecto.Migration

  def change do
    alter table(:vaccination) do
      add :person, references(:person, on_delete: :delete_all)
      add :health_professional, references(:health_professional, on_delete: :nothing)
      add :vaccine, references(:vaccine, on_delete: :nothing)
    end
  end
end
