defmodule MysportApi.Shipping.Depot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "depots" do
    field :name, :string
    field :shipped, :boolean, default: false
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(depot, attrs) do
    depot
    |> cast(attrs, [:name, :year, :shipped])
    |> validate_required([:name, :year, :shipped])
  end
end
