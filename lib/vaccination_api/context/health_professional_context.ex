defmodule VaccinationApi.HealthProfessionalContext do
  @moduledoc """
    Context of health_professional functions
  """
  alias VaccinationApi.Core.HealthProfessional
  alias VaccinationApi.UserContext
  alias VaccinationApi.Utils
  import Happy

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_first_name {:ok, _first_name} = Utils.get_param(params, "first_name")
      @params_last_name {:ok, _last_name} = Utils.get_param(params, "last_name")
      @params_cpf {:ok, _cpf} = Utils.get_param(params, "cpf")
      @params_professional_register {:ok, _professional_register} = Utils.get_param(params, "professional_register")

      @params_user {:ok, user_params} = Utils.get_param(params, "user")
      @user {:ok, user} = UserContext.create(user_params)

      {:ok, health_professional} =
        params
        |> Map.put("user_id", user.id)
        |> HealthProfessional.Api.insert()
        |> Utils.visible_fields(permission)

      {:ok, health_professional}
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
      @params_health_professional_id {:ok, health_professional_id} = Utils.get_param(params, "health_professional_id")

      @health_professional {:ok, health_professional} = HealthProfessional.Api.get(health_professional_id)

      # @granted_authed true = authed.id == health_professional_id

      {:ok, health_professional}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    HealthProfessional.Api.all(
      select: HealthProfessional.bee_permission(permission)
    )
  end

  def patch(params) do
    # authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_health_professional_id {:ok, health_professional_id} = Utils.get_param(params, "health_professional_id")
      @health_professional {:ok, health_professional} = HealthProfessional.Api.get(health_professional_id)

      # @granted_authed true = authed.id == health_professional_id

      HealthProfessional.Api.update(health_professional, params)
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
      @params_health_professional_id {:ok, health_professional_id} = Utils.get_param(params, "health_professional_id")
      @health_professional {:ok, health_professional} = HealthProfessional.Api.get(health_professional_id)

      # @granted_authed true = authed.id == health_professional_id

      HealthProfessional.Api.delete(health_professional)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
