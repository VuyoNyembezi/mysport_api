defmodule MysportApiWeb.DepotControllerTest do
  use MysportApiWeb.ConnCase

  import MysportApi.ShippingFixtures

  alias MysportApi.Shipping.Depot

  @create_attrs %{
    name: "some name",
    shipped: true,
    year: 42
  }
  @update_attrs %{
    name: "some updated name",
    shipped: false,
    year: 43
  }
  @invalid_attrs %{name: nil, shipped: nil, year: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all depots", %{conn: conn} do
      conn = get(conn, Routes.depot_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create depot" do
    test "renders depot when data is valid", %{conn: conn} do
      conn = post(conn, Routes.depot_path(conn, :create), depot: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.depot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "shipped" => true,
               "year" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.depot_path(conn, :create), depot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update depot" do
    setup [:create_depot]

    test "renders depot when data is valid", %{conn: conn, depot: %Depot{id: id} = depot} do
      conn = put(conn, Routes.depot_path(conn, :update, depot), depot: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.depot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "shipped" => false,
               "year" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, depot: depot} do
      conn = put(conn, Routes.depot_path(conn, :update, depot), depot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete depot" do
    setup [:create_depot]

    test "deletes chosen depot", %{conn: conn, depot: depot} do
      conn = delete(conn, Routes.depot_path(conn, :delete, depot))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.depot_path(conn, :show, depot))
      end
    end
  end

  defp create_depot(_) do
    depot = depot_fixture()
    %{depot: depot}
  end
end
