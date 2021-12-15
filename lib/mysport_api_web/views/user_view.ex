defmodule MysportApiWeb.UserView do
  use MysportApiWeb, :view
  alias MysportApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("signedup.json", %{user: user}) do
    %{
      email: user.email,
      password_hash: user.password_hash
    }
  end

  #view for sign in with cookies with cookies
  def render("token.json", %{access_token: access_token}) do
    %{
      access_token: access_token
    }
  end
  #  #view for refresh generator
  # def render("tokens.json", %{access_token: access_token}) do
  #   %{
  #     access_token: access_token
  #   }
  # end

  def render("auth.json", %{token: token}) do
    %{
      token: token
    }
  end

    def render("shownew.json", %{user: user}) do
    %{data: render_one(user, UserView, "signedup.json")}
    end
end
