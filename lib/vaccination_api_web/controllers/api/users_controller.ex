defmodule VaccinationApiWeb.UsersController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.UserContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create user

    ---| swagger |---
      tag "users"
      post "/api/users"
      consumes "application/json"
      produces "application/json"
      request_body do
        username :string, "Username", example: "joe_doe"
        email :string, "Email", example: "joe_doe@gmail.com"
        password :string, "Password", example: "J@D123456"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.User._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> UserContext.create()
    |> Response.pipe(conn)
  end
end
