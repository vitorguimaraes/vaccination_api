defmodule VaccinationApiWeb.AuthController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.UserContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Login

    ---| swagger |---
      tag "auth"
      post "/api/auth/login"
      consumes "application/json"
      produces "application/json"
      request_body do
        email :string, "Email", example: "joe_doe@gmail.com"
        password :string, "Password", example: "J@D123456"
      end
      VaccinationApiWeb.Response.swagger 200, data: []
    ---| end |---
  """
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

  @doc """
    Logout

    ---| swagger |---
      tag "auth"
      post "/api/auth/logout"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      VaccinationApiWeb.Response.swagger 200, data: []
    ---| end |---
  """
  def logout(conn, _params) do
    token = conn.private.guardian_default_token

    Auth.revoke(token)
    |> case do
      {:ok, _} -> Response.success(:ok, conn)
      {:error, error} -> Response.error(error, conn)
    end
  end
end
