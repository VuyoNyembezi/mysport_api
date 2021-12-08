defmodule MysportApiWeb.UserController do

  use MysportApiWeb, :controller
  use Guardian, otp_app: :mysport_api

  alias MysportApi.Authentication.Guardian
  alias MysportApi.Accounts
  alias MysportApi.Accounts.User

  action_fallback MysportApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end


  def signup(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.sign_up(user_params) do
      conn
      |> put_status(:created)
      |> render("signedup.json", user: user)
    end
  end


  def signin(email, password) do
    with {:ok, %User{}= user} <- Accounts.get_by_email(email) do
      case validate_password(password, user.password_hash) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end





  def signintest(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok,user,token} ->
      conn
        |> render("user.json", %{user: user, token: token})
      {:error, :unauthorized} ->
        body = Jason.encode!(%{error: "unauthorized"})
        conn
         |> send_resp(401, body)
    end
   end



  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end



   #these functions are used for authentication
   defp validate_password(password, password_hash) do
    Pbkdf2.verify_pass(password, password_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    {:ok, user, token}
  end

end
