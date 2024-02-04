defmodule VaccinationApiWeb.PersonsController do
  use VaccinationApiWeb, :controller

  alias VaccinationApi.PersonContext
  alias VaccinationApiWeb.{Auth, Response}

  @doc """
    Create person

    ---| swagger |---
      tag "persons"
      post "/api/persons"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      request_body do
        first_name :string, "First Name", example: "Joe"
        last_name :string, "Last Name", example: "Doe"
        birth :date, "Birth date", example: "1990-09-23"
        cpf :string, "CPF", example: "164.892.360-79"
        sus_number :string, "SUS Number", example: "123456789ABCDEF"
        mother_name :string, "Mother Name", example: "Marylin Roberts"
        gender :string, "Gender", example: "male"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Person._swagger_schema_(:basic)
    ---| end |---
  """
  def create(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.create()
    |> Response.pipe(conn)
  end

  @doc """
    Get one person by id

    ---| swagger |---
      tag "persons"
      get "/api/persons/{person_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        person_id :path, :string, "Person id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, VaccinationApi.Core.Person._swagger_schema_(:basic)
    ---| end |---
  """
  def one(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.one()
    |> Response.pipe(conn)
  end

  @doc """
    Get all persons

    ---| swagger |---
      tag "persons"
      get "/api/persons"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      VaccinationApiWeb.Response.swagger 200, data: [VaccinationApi.Core.Person._swagger_schema_(:basic)]
    ---| end |---
  """
  def all(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.all()
    |> Response.pipe(conn)
  end

  @doc """
    Update person

    ---| swagger |---
      tag "persons"
      patch "/api/persons/{person_id}"
      consumes "application/json"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        person_id :path, :string, "Person id", required: true
      end
      request_body do
        first_name :string, "First Name", example: "Joe"
        last_name :string, "Last Name", example: "Doe"
        birth :date, "Birth date", example: "1990-09-23"
        cpf :string, "CPF", example: "164.892.360-79"
        sus_number :string, "SUS Number", example: "123456789ABCDEF"
        mother_name :string, "Mother Name", example: "Marylin Roberts"
        gender :string, "Gender", example: "male"
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Person._swagger_schema_(:basic)
    ---| end |---
  """
  def patch(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.patch()
    |> Response.pipe(conn)
  end

  @doc """
    Delete person by id

    ---| swagger |---
      tag "persons"
      delete "/api/persons/{person_id}"
      produces "application/json"
      parameter "authorization", :header, :string, "Access Token"
      parameters do
        person_id :path, :string, "Person id", required: true
      end
      VaccinationApiWeb.Response.swagger 200, data: VaccinationApi.Core.Person._swagger_schema_(:basic)
    ---| end |---
  """
  def delete(conn, params) do
    params
    |> Map.put("authed", Auth.get_user(conn))
    |> Map.put("permission", Auth.get_permission(conn))
    |> PersonContext.delete()
    |> Response.pipe(conn)
  end
end
