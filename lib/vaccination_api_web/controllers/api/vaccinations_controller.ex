defmodule VaccinationApiWeb.VaccinationsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.VaccinationContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.create()
    |> Response.pipe(conn)
  end

  def one_by_professional(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.one_by_professional()
    |> Response.pipe(conn)
  end

  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.all()
    |> Response.pipe(conn)
  end

  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.patch()
    |> Response.pipe(conn)
  end
end
