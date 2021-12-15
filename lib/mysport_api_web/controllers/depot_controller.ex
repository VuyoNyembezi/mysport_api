defmodule MysportApiWeb.DepotController do
  use MysportApiWeb, :controller

  alias MysportApi.Shipping
  alias MysportApi.Shipping.Depot

  action_fallback MysportApiWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()

  def index(conn, _params) do
    depots = Shipping.list_depots()
    render(conn, "index.json", depots: depots)
  end

  def create(conn, %{"depot" => depot_params}) do
    with {:ok, %Depot{} = depot} <- Shipping.create_depot(depot_params) do
      conn
      |> put_status(:created)
      |> render("new.json", depot: depot)
    end
  end

  def show(conn, %{"id" => id}) do
    depot = Shipping.get_depot!(id)
    render(conn, "show.json", depot: depot)
  end

  def update(conn, %{"id" => id, "depot" => depot_params}) do
    depot = Shipping.get_depot!(id)

    with {:ok, %Depot{} = depot} <- Shipping.update_depot(depot, depot_params) do
      render(conn, "show.json", depot: depot)
    end
  end

  def delete(conn, %{"id" => id}) do
    depot = Shipping.get_depot!(id)

    with {:ok, %Depot{}} <- Shipping.delete_depot(depot) do
      send_resp(conn, :no_content, "")
    end
  end
end
