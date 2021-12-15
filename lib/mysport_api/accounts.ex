defmodule MysportApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  use Guardian, otp_app: :mysport_api

  alias MysportApi.Authentication.Guardian
  alias MysportApi.Repo

  alias MysportApi.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def sign_up(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """


  def get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        {:ok, user}
    end
  end

  def authenticate_user(email, password) do
    case get_by_email(email) do
      {:ok, user} ->
      case validate_password(password, user.password_hash) do
        true -> {:ok, user}
        false -> {:error, :unauthorized}
      end
      {:error, :not_found} ->
        {:error, :unauthorized}
    end
  end

  #for the controller with cookie generator

  def authenticate_tester(email, password) do
    case get_by_email(email) do
      {:ok, user} ->
      case validate_password(password, user.password_hash) do
        true -> {:ok, user}
        false -> {:error, :unauthorized}
      end
      {:error, :not_found} ->
        {:error, :unauthorized}
    end
  end





  def validate_password(password, password_hash) do
    Pbkdf2.verify_pass(password, password_hash)
  end



  defp create_token(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    {:ok,user, token}
  end


  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
