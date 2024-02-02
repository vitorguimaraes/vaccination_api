defmodule VaccinationApi.HealthCenterContext do
  @moduledoc """
    Context of health_center functions
  """
  alias VaccinationApi.Core.HealthCenter
  alias VaccinationApi.Utils
  import Happy

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_name {:ok, _name} = Utils.get_param(params, "name")
      @params_phone {:ok, _phone} = Utils.get_param(params, "phone")
      @params_cnes {:ok, _cnes} = Utils.get_param(params, "CNES")

      # @granted_authed true = authed.id == health_center_id

      {:ok, health_center} =
        HealthCenter.Api.insert(params)
        |> Utils.visible_fields(permission)

      {:ok, health_center}
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
      @params_health_center_id {:ok, health_center_id} = Utils.get_param(params, "health_center_id")

      @health_center {:ok, health_center} = HealthCenter.Api.get(health_center_id)

      # @granted_authed true = authed.id == health_center_id

      {:ok, health_center}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    HealthCenter.Api.all(
      select: HealthCenter.bee_permission(permission)
    )
  end

  def patch(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_health_center_id {:ok, health_center_id} = Utils.get_param(params, "health_center_id")
      @health_center {:ok, health_center} = HealthCenter.Api.get(health_center_id)

      # @granted_authed true = authed.id == health_center_id

      HealthCenter.Api.update(health_center, params)
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
      @params_health_center_id {:ok, health_center_id} = Utils.get_param(params, "health_center_id")
      @health_center {:ok, health_center} = HealthCenter.Api.get(health_center_id)

      # @granted_authed true = authed.id == health_center_id

      HealthCenter.Api.delete(health_center)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
