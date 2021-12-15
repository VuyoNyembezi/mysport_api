defmodule MysportApi.ShippingTest do
  use MysportApi.DataCase

  alias MysportApi.Shipping

  describe "depots" do
    alias MysportApi.Shipping.Depot

    import MysportApi.ShippingFixtures

    @invalid_attrs %{name: nil, shipped: nil, year: nil}

    test "list_depots/0 returns all depots" do
      depot = depot_fixture()
      assert Shipping.list_depots() == [depot]
    end

    test "get_depot!/1 returns the depot with given id" do
      depot = depot_fixture()
      assert Shipping.get_depot!(depot.id) == depot
    end

    test "create_depot/1 with valid data creates a depot" do
      valid_attrs = %{name: "some name", shipped: true, year: 42}

      assert {:ok, %Depot{} = depot} = Shipping.create_depot(valid_attrs)
      assert depot.name == "some name"
      assert depot.shipped == true
      assert depot.year == 42
    end

    test "create_depot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shipping.create_depot(@invalid_attrs)
    end

    test "update_depot/2 with valid data updates the depot" do
      depot = depot_fixture()
      update_attrs = %{name: "some updated name", shipped: false, year: 43}

      assert {:ok, %Depot{} = depot} = Shipping.update_depot(depot, update_attrs)
      assert depot.name == "some updated name"
      assert depot.shipped == false
      assert depot.year == 43
    end

    test "update_depot/2 with invalid data returns error changeset" do
      depot = depot_fixture()
      assert {:error, %Ecto.Changeset{}} = Shipping.update_depot(depot, @invalid_attrs)
      assert depot == Shipping.get_depot!(depot.id)
    end

    test "delete_depot/1 deletes the depot" do
      depot = depot_fixture()
      assert {:ok, %Depot{}} = Shipping.delete_depot(depot)
      assert_raise Ecto.NoResultsError, fn -> Shipping.get_depot!(depot.id) end
    end

    test "change_depot/1 returns a depot changeset" do
      depot = depot_fixture()
      assert %Ecto.Changeset{} = Shipping.change_depot(depot)
    end
  end
end
