defmodule VaccinationApi.Repo.Migrations.RenamePersonColumn do
  use Ecto.Migration

  def change do
    rename table(:person), :password, to: :hashed_password
  end
end
