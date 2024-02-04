defmodule VaccinationApiWeb.VaccinationsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.VaccinationContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create vaccination

    ---| swagger |---
      tag "vaccinations"
      post "/api/health_professionals/{health_professional_id}/persons/{person_id}/vaccinations"
      consumes "application/json"
      produces "application/json"
      request_body do
        shot :string, "Shot", example: "shot_1"
        date :date, "Date", example: "2024-01-28T12:34:56.789Z"
        vaccine_id :string, "Vaccine id"
        health_center_id :string, "Health Center id"
      end
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
        person_id :path, :string, "Person id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccination._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.create()
    |> Response.pipe(conn)
  end

  @doc """
    Get one vaccination by professional_id

    ---| swagger |---
      tag "vaccinations"
      get "/api/health_professionals/{health_professional_id}/vaccinations/{vaccination_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
        vaccination_id :path, :string, "Vaccination id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, VaccinationApi.Core.Vaccination._swagger_schema_(:basic)
    ---| end |---
  """
  def one_by_professional(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.one_by_professional()
    |> Response.pipe(conn)
  end

  @doc """
    Get one vaccination by person id

    ---| swagger |---
      tag "vaccinations"
      get "/api/persons/{person_id}/vaccinations/{vaccination_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        person_id :path, :string, "Person id", required: true
        vaccination_id :path, :string, "Vaccination id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, VaccinationApi.Core.Vaccination._swagger_schema_(:basic)
    ---| end |---
  """
  def one_by_person(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.one_by_person()
    |> Response.pipe(conn)
  end

  @doc """
    Get all vaccinations by health professional id

    ---| swagger |---
      tag "vaccinations"
      get "/api/health_professionals/{health_professional_id}/vaccinations/{vaccination_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
        vaccination_id :path, :string, "Vaccination id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.Vaccination._swagger_schema_(:basic)]
    ---| end |---
  """
  def all_by_professional(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.all_by_professional()
    |> Response.pipe(conn)
  end

  @doc """
    Get all vaccinations by person

    ---| swagger |---
      tag "vaccinations"
      get "/api/persons/{person_id}/vaccinations/{vaccination_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        person_id :path, :string, "Person id", required: true
        vaccination_id :path, :string, "Vaccination id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.Vaccination._swagger_schema_(:basic)]
    ---| end |---
  """
  def all_by_person(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.all_by_person()
    |> Response.pipe(conn)
  end

  @doc """
    Update vaccination

    ---| swagger |---
      tag "vaccinations"
      patch "/api/health_professionals/{health_professional_id}/vaccinations/{vaccination_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      request_body do
        shot :string, "Shot", example: "shot_1"
        date :date, "Date", example: "2024-01-28T12:34:56.789Z"
      end
      parameters do
        health_professional_id :path, :string, "Health Professional id", required: true
        vaccination_id :path, :string, "Vaccination id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Vaccination._swagger_schema_(:basic)
    ---| end |---
  """
  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> VaccinationContext.patch()
    |> Response.pipe(conn)
  end
end
