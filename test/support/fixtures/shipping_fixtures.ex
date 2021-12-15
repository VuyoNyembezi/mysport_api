defmodule MysportApi.ShippingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MysportApi.Shipping` context.
  """

  @doc """
  Generate a depot.
  """
  def depot_fixture(attrs \\ %{}) do
    {:ok, depot} =
      attrs
      |> Enum.into(%{
        name: "some name",
        shipped: true,
        year: 42
      })
      |> MysportApi.Shipping.create_depot()

    depot
  end
end
