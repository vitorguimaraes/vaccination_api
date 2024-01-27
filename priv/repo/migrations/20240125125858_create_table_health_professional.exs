defmodule VaccinationApi.Repo.Migrations.CreateHealthProfessional do
  use Ecto.Migration

  def change do
    create table(:health_professional) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :cpf, :string, null: false, null: false
      add :professional_register, :string, null: false, null: false
      add :email, :string, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end
  end
end
