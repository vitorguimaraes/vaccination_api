defmodule VaccinationApi.PersonContext do
  @moduledoc """
    Context of person functions
  """
  alias VaccinationApi.Core.Person
  alias VaccinationApi.UserContext
  alias VaccinationApi.Utils
  import Happy

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_first_name {:ok, _first_name} = Utils.get_param(params, "first_name")
      @params_last_name {:ok, _last_name} = Utils.get_param(params, "last_name")
      @params_birth {:ok, _birth} = Utils.get_param(params, "birth")
      @params_cpf {:ok, _cpf} = Utils.get_param(params, "cpf")
      @params_sus_number {:ok, _sus_number} = Utils.get_param(params, "sus_number")
      @params_mother_name {:ok, _mother_name} = Utils.get_param(params, "mother_name")
      @params_gender {:ok, _gender} = Utils.get_param(params, "gender")

      @params_user {:ok, user_params} = Utils.get_param(params, "user")
      @user {:ok, user} = UserContext.create(user_params)

      {:ok, person} =
        params
        |> Map.put("user_id", user.id)
        |> Person.Api.insert()
        |> Utils.visible_fields(permission)

      {:ok, person}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:error, error} -> {:error, error}
    end
  end

  def one(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")

      @person {:ok, person} = Person.Api.get(person_id)

      # @granted_authed true = authed.id == person_id

      {:ok, person}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    Person.Api.all(
      select: Person.bee_permission(permission)
    )
  end

  def patch(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")
      @person {:ok, person} = Person.Api.get(person_id)

      # @granted_authed true = authed.id == person_id

      Person.Api.update(person, params)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end

  def delete(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")
      @person {:ok, person} = Person.Api.get(person_id)

      # @granted_authed true = authed.id == person_id

      Person.Api.delete(person)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
