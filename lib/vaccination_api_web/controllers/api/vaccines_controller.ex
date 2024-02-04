defmodule VaccinationApiWeb.VaccinesController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.VaccineContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create vaccine

    ---| swagger |---
      tag "vaccines"
      post "/api/vaccines"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      request_body do
        name :string, "Name", example: "Pfizer"
        lot :string, "Lot", example: "ABC123"
        expiration_date :string, "Expiration Date", example: "2024-05-12"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccine._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.create()
    |> Response.pipe(conn)
  end

  @doc """
    Get one vaccine by id

    ---| swagger |---
      tag "vaccines"
      get "/api/vaccines/{vaccine_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        vaccine_id :path, :string, "Vaccine id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccine._swagger_schema_(:basic)
    ---| end |---
  """
  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.one()
    |> Response.pipe(conn)
  end

  @doc """
    Get all health professionals

    ---| swagger |---
      tag "vaccines"
      get "/api/vaccines"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.Vaccine._swagger_schema_(:basic)]
    ---| end |---
  """
  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.all()
    |> Response.pipe(conn)
  end

  @doc """
    Update vaccine

    ---| swagger |---
      tag "vaccines"
      patch "/api/vaccines/{vaccine_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        vaccine_id :path, :string, "Health Professional id", required: true
      end
      request_body do
        name :string, "Name", example: "Pfizer"
        lot :string, "Lot", example: "ABC123"
        expiration_date :string, "Expiration Date", example: "2024-05-12"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccine._swagger_schema_(:basic)
    ---| end |---
  """
  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.patch()
    |> Response.pipe(conn)
  end

  @doc """
    Delete vaccine by id

    ---| swagger |---
      tag "vaccines"
      delete "/api/vaccines/{vaccine_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        vaccine_id :path, :string, "Health Professional id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccine._swagger_schema_(:basic)
    ---| end |---
  """
  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccineContext.delete()
    |> Response.pipe(conn)
  end
end
