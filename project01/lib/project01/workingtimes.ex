defmodule Project01.Workingtimes do
  @moduledoc """
  The Workingtimes context.
  """

  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]
  alias Project01.Repo

  alias Project01.Workingtimes.Workingtime
  alias Project01.Users
  alias Project01.Users.User

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  def get!() do
    query = (from u in Workingtime,
                select: %Workingtime{id: u.id, start: u.start, end: u.end, user_id: u.user_id})
    Repo.all(query)
  end

  def get_workingtimes_by_user_id!(userID) do
    query = (from u in Workingtime,
                where: u.user_id == ^(userID),
                select: %Workingtime{id: u.id, start: u.start, end: u.end, user_id: u.user_id})
    Repo.all(query)
  end

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(%User{} = users, attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, users.id)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{source: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime) do
    Workingtime.changeset(workingtime, %{})
  end
end
