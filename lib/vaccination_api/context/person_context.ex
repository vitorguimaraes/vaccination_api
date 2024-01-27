defmodule VaccinationApi.PersonContext do
  @moduledoc """
    Context of person functions
  """
  alias VaccinationApi.Core.Person
  alias VaccinationApi.Utils
  import Happy

  @doc """
    Authenticates person access
    params:
      - email
      - password
  """
  def authenticate_access(params) do
    happy_path do
      # required params
      @param_email {:ok, email} = Utils.get_param(params, "email")
      @param_password {:ok, password} = Utils.get_param(params, "password")

      @person {:ok, person} = Person.Api.get_by(where: [email: email])

      @password true = Person.Api.check_password(person, password)
      {:ok, person}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:password, false} -> {:error, "email_or_password_invalid"}
    end
  end

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_first_name {:ok, first_name} = Utils.get_param(params, "first_name")
      @params_last_name {:ok, last_name} = Utils.get_param(params, "last_name")
      @params_birth {:ok, birth} = Utils.get_param(params, "birth")
      @params_cpf {:ok, cpf} = Utils.get_param(params, "cpf")
      @params_sus_number {:ok, sus_number} = Utils.get_param(params, "sus_number")
      @params_mother_name {:ok, mother_name} = Utils.get_param(params, "mother_name")
      @params_gender {:ok, gender} = Utils.get_param(params, "gender")
      @params_email {:ok, email} = Utils.get_param(params, "email")
      @params_password {:ok, password} = Utils.get_param(params, "password")

      insert_params = %{
        first_name: first_name,
        last_name: last_name,
        birth: birth,
        cpf: cpf,
        sus_number: sus_number,
        mother_name: mother_name,
        gender: gender,
        email: email,
        __password__: password
      }

      {:ok, person} =
        Person.Api.insert(insert_params)
        |> Utils.visible_fields(permission)

      {:ok, person}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:error, error} -> {:error, error}
    end
  end

  def one(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")

      @person {:ok, person} = Person.Api.get(person_id)

      @granted_authed true = authed.id == person_id

      {:ok, person}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    Person.Api.all(
      select: Person.bee_permission(permission)
    )
  end

  def patch(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")
      @person {:ok, person} = Person.Api.get(person_id)

      @granted_authed true = authed.id == person_id

      Person.Api.update(person, params)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end

  def delete(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")
      @person {:ok, person} = Person.Api.get(person_id)

      @granted_authed true = authed.id == person_id

      Person.Api.delete(person)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
