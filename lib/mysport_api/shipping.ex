defmodule MysportApi.Shipping do
  @moduledoc """
  The Shipping context.
  """

  import Ecto.Query, warn: false
  alias MysportApi.Repo

  alias MysportApi.Shipping.Depot

  @doc """
  Returns the list of depots.

  ## Examples

      iex> list_depots()
      [%Depot{}, ...]

  """
  def list_depots do
    Repo.all(Depot)
  end

  @doc """
  Gets a single depot.

  Raises `Ecto.NoResultsError` if the Depot does not exist.

  ## Examples

      iex> get_depot!(123)
      %Depot{}

      iex> get_depot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_depot!(id), do: Repo.get!(Depot, id)

  @doc """
  Creates a depot.

  ## Examples

      iex> create_depot(%{field: value})
      {:ok, %Depot{}}

      iex> create_depot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_depot(attrs \\ %{}) do
    %Depot{}
    |> Depot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a depot.

  ## Examples

      iex> update_depot(depot, %{field: new_value})
      {:ok, %Depot{}}

      iex> update_depot(depot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_depot(%Depot{} = depot, attrs) do
    depot
    |> Depot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a depot.

  ## Examples

      iex> delete_depot(depot)
      {:ok, %Depot{}}

      iex> delete_depot(depot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_depot(%Depot{} = depot) do
    Repo.delete(depot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking depot changes.

  ## Examples

      iex> change_depot(depot)
      %Ecto.Changeset{data: %Depot{}}

  """
  def change_depot(%Depot{} = depot, attrs \\ %{}) do
    Depot.changeset(depot, attrs)
  end
end
