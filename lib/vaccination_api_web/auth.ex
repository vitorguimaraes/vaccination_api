defmodule VaccinationApiWeb.Auth do
  @moduledoc """
    Manages the Authenticated User
  """
  use Guardian, otp_app: :vaccination_api
  alias VaccinationApi.Core.Person
  alias VaccinationApiWeb.Auth.Plug

  @doc false
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    Person.Api.get(id)
  end

  @doc """
    Get permission from authed user
  """
  def get_permission(_conn), do: nil

  @doc """
    Get authed user data
  """
  def get_user(conn), do: Plug.current_resource(conn)
end
