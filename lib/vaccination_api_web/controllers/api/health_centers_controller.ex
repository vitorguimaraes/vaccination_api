defmodule VaccinationApiWeb.HealthCentersController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.HealthCenterContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.create()
    |> Response.pipe(conn)
  end

  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.one()
    |> Response.pipe(conn)
  end

  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.all()
    |> Response.pipe(conn)
  end

  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.patch()
    |> Response.pipe(conn)
  end

  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.delete()
    |> Response.pipe(conn)
  end
end
