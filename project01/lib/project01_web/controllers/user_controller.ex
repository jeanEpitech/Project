defmodule Project01Web.UserController do
  use Project01Web, :controller

  alias Project01.Users
  alias Project01.Users.User

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def showByName(conn, %{"email" => email, "username" => username}) do
    users = Users.get_user_by_name!(username, email)
    IO.inspect(users)
    render(conn, "index.json", users: users)
    # with {:ok, %User{} = user} <- Users.create_user(user_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.user_path(conn, :show, user))
    #   |> render("show.json", user: user)
    # end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
