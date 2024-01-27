defmodule VaccinationApi.HealthProfessionalContext do
  @moduledoc """
    Context of health_professional functions
  """
  alias VaccinationApi.Core.HealthProfessional
  alias VaccinationApi.Utils
  import Happy

  @doc """
    Authenticates health_professional access
    params:
      - email
      - password
  """
  # def authenticate_access(params) do
  #   happy_path do
  #     # required params
  #     @param_email {:ok, email} = Utils.get_param(params, "email")
  #     @param_password {:ok, password} = Utils.get_param(params, "password")

  #     @health_professional {:ok, health_professional} = HealthProfessional.Api.get_by(where: [email: email])

  #     @password true = HealthProfessional.Api.check_password(health_professional, password)
  #     {:ok, health_professional}
  #   else
  #     {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
  #     {:password, false} -> {:error, "email_or_password_invalid"}
  #   end
  # end

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_first_name {:ok, first_name} = Utils.get_param(params, "first_name")
      @params_last_name {:ok, last_name} = Utils.get_param(params, "last_name")
      @params_cpf {:ok, cpf} = Utils.get_param(params, "cpf")
      @params_professional_register {:ok, professional_register} = Utils.get_param(params, "professional_register")
      @params_email {:ok, email} = Utils.get_param(params, "email")
      @params_password {:ok, password} = Utils.get_param(params, "password")

      insert_params = %{
        first_name: first_name,
        last_name: last_name,
        cpf: cpf,
        professional_register: professional_register,
        email: email,
        __password__: password
      }

      {:ok, health_professional} =
        HealthProfessional.Api.insert(insert_params)
        |> Utils.visible_fields(permission)

      {:ok, health_professional}
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
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    HealthProfessional.Api.all(
      select: HealthProfessional.bee_permission(permission)
    )
  end

  def patch(params) do
    authed = Access.get(params, "authed")
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
    authed = Access.get(params, "authed")
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
