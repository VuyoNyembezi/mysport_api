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

  #sign in controller with cookie generator for reresh token

  def signin(conn, %{"email" => email,"password" => password}) do

    case Accounts.authenticate_tester(email, password) do
      {:ok, user} ->
        {:ok, access_token, _claims} =
        Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {15, :minute})

      {:ok, refresh_token, _claims} =
      Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {5, :day})
      conn
      |> put_resp_cookie("ruid", refresh_token)
      |> put_status(:created)
      |> render("token.json",access_token: access_token)

    {:error, :unauthorized} ->
      body = Jason.encode!(%{error: "unauthorized wrong input"})
      conn
      |> send_resp(401, body)
    end
  end

  def refresh(conn, _params) do
    refresh_token =
    Plug.Conn.fetch_cookies(conn) |> Map.from_struct() |> get_in([:cookies, "ruid"])

    case Guardian.exchange(refresh_token, "refresh", "access") do
      {:ok, _old_stuff, {new_access_token, _new_claims}} ->
        conn
        |> put_status(:created)
        |> render("token.json",%{access_token: new_access_token})
      {:error, :unauthorized} ->
        body = Jason.encode!(%{error: "unauthorized"})
        conn
        |> send_resp(401, body)
    end
  end

  def  delete(conn, _params) do
    conn
      |> delete_resp_cookie("ruid")
      |> put_status(200)
      |> text("Log out successfully")
  end

end
