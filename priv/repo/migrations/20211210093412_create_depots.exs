defmodule MysportApi.Repo.Migrations.CreateDepots do
  use Ecto.Migration

  def change do
    create table(:depots) do
      add :name, :string
      add :year, :integer
      add :shipped, :boolean, default: false, null: false

      timestamps()
    end
  end
end
