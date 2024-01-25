defmodule VaccinationApi.Repo.Migrations.CreateHealthProfessional do
  use Ecto.Migration

  def change do
    create table(:health_professional) do
      add :first_name, :string
      add :last_name, :string
      add :professional_register, :string, required: true
      add :cpf, :string, required: true

      timestamps()
    end
  end
end
