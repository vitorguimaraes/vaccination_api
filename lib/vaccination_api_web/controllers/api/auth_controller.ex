defmodule VaccinationApiWeb.AuthController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.UserContext
  alias VaccinationApiWeb.{Auth, Response}

  def login(conn, params) do
    params
    |> UserContext.authenticate_access()
    |> case do
      {:ok, user} ->
        {:ok, token, _claims} = Auth.encode_and_sign(user)

        %{
          token: token
        }
        |> Response.success(conn)

      {:error, data} ->
        Response.error(data, conn)
    end
  end

  def logout(conn, _params) do
    token = conn.private.guardian_default_token

    Auth.revoke(token)
    |> case do
      {:ok, _} -> Response.success(:ok, conn)
      {:error, error} -> Response.error(error, conn)
    end
  end
end
