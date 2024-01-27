defmodule VaccinationApiWeb.AuthController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.PersonContext
  alias VaccinationApiWeb.{Auth, Response}

  def login(conn, params) do
    params
    |> PersonContext.authenticate_access()
    |> case do
      {:ok, person} ->
        {:ok, token, _claims} = Auth.encode_and_sign(person)

        %{
          token: token
        }
        |> Response.success(conn)

      {:error, data} ->
        Response.error(data, conn)
    end
  end
end
