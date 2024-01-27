defmodule VaccinationApiWeb.VaccinesController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.VaccineContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.create()
    |> Response.pipe(conn)
  end

  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.one()
    |> Response.pipe(conn)
  end

  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.all()
    |> Response.pipe(conn)
  end

  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.patch()
    |> Response.pipe(conn)
  end

  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.delete()
    |> Response.pipe(conn)
  end
end
