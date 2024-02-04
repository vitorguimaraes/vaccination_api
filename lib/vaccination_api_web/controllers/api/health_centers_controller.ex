defmodule VaccinationApiWeb.HealthCentersController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.HealthCenterContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create health center

    ---| swagger |---
      tag "health_centers"
      post "/api/health_centers"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      request_body do
        name :string, "Name", example: "Unidade Básica de Saúde"
        phone :string, "Phone", example: "85993782314"
        cnes :string, "CNES", example: "123543513"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthCenter._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.create()
    |> Response.pipe(conn)
  end

  @doc """
    Get one health center by id

    ---| swagger |---
      tag "health_centers"
      get "/api/health_centers/{health_center_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_center_id :path, :string, "Health Center id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthCenter._swagger_schema_(:basic)
    ---| end |---
  """
  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.one()
    |> Response.pipe(conn)
  end

  @doc """
    Get all health centers

    ---| swagger |---
      tag "health_centers"
      get "/api/health_centers"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.HealthCenter._swagger_schema_(:basic)]
    ---| end |---
  """
  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.all()
    |> Response.pipe(conn)
  end

  @doc """
    Update health center

    ---| swagger |---
      tag "health_centers"
      patch "/api/health_centers/{health_center_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_center_id :path, :string, "Health Center id", required: true
      end
      request_body do
        name :string, "Name", example: "Unidade Básica de Saúde"
        phone :string, "Phone", example: "85993782314"
        cnes :string, "CNES", example: "123543513"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthCenter._swagger_schema_(:basic)
    ---| end |---
  """
  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.patch()
    |> Response.pipe(conn)
  end

  @doc """
    Delete health center

    ---| swagger |---
      tag "health_centers"
      delete "/api/health_centers/{health_center_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_center_id :path, :string, "Health Center id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthCenter._swagger_schema_(:basic)
    ---| end |---
  """
  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthCenterContext.delete()
    |> Response.pipe(conn)
  end
end
