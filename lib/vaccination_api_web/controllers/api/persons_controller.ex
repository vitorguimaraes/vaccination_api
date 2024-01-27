defmodule VaccinationApiWeb.PersonsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.PersonContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.create()
    |> Response.pipe(conn)
  end

  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.one()
    |> Response.pipe(conn)
  end

  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.all()
    |> Response.pipe(conn)
  end

  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.patch()
    |> Response.pipe(conn)
  end

  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.delete()
    |> Response.pipe(conn)
  end
end
