defmodule Project01.Clocks do
  @moduledoc """
  The Clocks context.
  """

  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]
  alias Project01.Repo

  alias Project01.Clocks.Clock
  alias Project01.Users
  alias Project01.Users.User

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)
  
  def get_clocks_by_user_id!(userID) do
    query = (from u in Clock,
                where: u.user_id == ^(userID),
                select: %Clock{id: u.id, time: u.time, user_id: u.user_id})
    Repo.all(query)
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_clock(attrs \\ %{}) do
  #   %Clock{}
  #   |> Clock.changeset(attrs)
  #   |> Repo.insert()
  # end
  def create_clock(%User{} = users, attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, users.id)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{source: %Clock{}}

  """
  def change_clock(%Clock{} = clock) do
    Clock.changeset(clock, %{})
  end
end
