defmodule VaccinationApiWeb.UsersController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.UserContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> UserContext.create()
    |> Response.pipe(conn)
  end
end
