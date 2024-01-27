defmodule VaccinationApiWeb.HealthProfessionalsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.HealthProfessionalContext
  alias VaccinationApiWeb.{Auth, Response}

  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.create()
    |> Response.pipe(conn)
  end

  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.one()
    |> Response.pipe(conn)
  end

  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.all()
    |> Response.pipe(conn)
  end

  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.patch()
    |> Response.pipe(conn)
  end

  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.delete()
    |> Response.pipe(conn)
  end
end
