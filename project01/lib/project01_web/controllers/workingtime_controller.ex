defmodule Project01Web.WorkingtimeController do
  use Project01Web, :controller

  alias Project01.Workingtimes
  alias Project01.Workingtimes.Workingtime
  # alias Project01.Users.User
  alias Project01.Users

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  # def create(conn, %{"workingtime" => workingtime_params}) do
  def create(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    
    user = Users.get_user!(user_id)
    IO.inspect(user)
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(user ,workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => user_id}) do
    workingtime = Workingtimes.get_workingtime!(user_id)
    IO.inspect(workingtime)
    render(conn, "show.json", workingtime: workingtime)
  end

  def showByUserId(conn, %{"userID" => user_id}) do
    workingtimes = Workingtimes.get_workingtimes_by_user_id!(user_id)
    IO.inspect(workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
