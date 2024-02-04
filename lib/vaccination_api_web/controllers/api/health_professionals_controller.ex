defmodule VaccinationApiWeb.HealthProfessionalsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.HealthProfessionalContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create health professional

    ---| swagger |---
      tag "health_professionals"
      post "/api/health_professionals"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      request_body do
        first_name :string, "First Name", example: "Joe"
        last_name :string, "Last Name", example: "Doe"
        cpf :string, "CPF", example: "164.892.360-79"
        professional_register :string, "SUS Number", example: "CREMEC-12345"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthProfessional._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.create()
    |> Response.pipe(conn)
  end

  @doc """
    Get one health professional by id

    ---| swagger |---
      tag "health_professionals"
      get "/api/health_professionals/{health_professional_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthProfessional._swagger_schema_(:basic)
    ---| end |---
  """
  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.one()
    |> Response.pipe(conn)
  end

  @doc """
    Get all health professionals

    ---| swagger |---
      tag "health_professionals"
      get "/api/health_professionals"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.HealthProfessional._swagger_schema_(:basic)]
    ---| end |---
  """
  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.all()
    |> Response.pipe(conn)
  end

  @doc """
    Update health professional

    ---| swagger |---
      tag "health_professionals"
      patch "/api/health_professionals/{health_professional_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
      end
      request_body do
        first_name :string, "First Name", example: "Joe"
        last_name :string, "Last Name", example: "Doe"
        cpf :string, "CPF", example: "164.892.360-79"
        professional_register :string, "SUS Number", example: "CREMEC-12345"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthProfessional._swagger_schema_(:basic)
    ---| end |---
  """
  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.patch()
    |> Response.pipe(conn)
  end

  @doc """
    Delete health professional by id

    ---| swagger |---
      tag "health_professionals"
      delete "/api/health_professionals/{health_professional_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.HealthProfessional._swagger_schema_(:basic)
    ---| end |---
  """
  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> HealthProfessionalContext.delete()
    |> Response.pipe(conn)
  end
end
