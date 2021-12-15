defmodule MysportApiWeb.DepotView do
  use MysportApiWeb, :view
  alias MysportApiWeb.DepotView

  def render("index.json", %{depots: depots}) do
    %{data: render_many(depots, DepotView, "depot.json")}
  end

  def render("show.json", %{depot: depot}) do
    %{data: render_one(depot, DepotView, "depot.json")}
  end

  def render("depot.json", %{depot: depot}) do
    %{
      id: depot.id,
      name: depot.name,
      year: depot.year,
      shipped: depot.shipped
    }
  end
  def render("new.json", %{depot: depot}) do
    %{

      name: depot.name,
      year: depot.year,
      shipped: depot.shipped
    }
  end
end
