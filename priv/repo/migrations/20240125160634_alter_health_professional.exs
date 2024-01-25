defmodule VaccinationApi.Repo.Migrations.AlterHealthProfessional do
  use Ecto.Migration

  def change do
    alter table(:health_professional) do
      add :email, :string
      add :hashed_password, :string
    end
  end
end
