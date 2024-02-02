defmodule VaccinationApi.VaccineContext do
  @moduledoc """
    Context of vaccine functions
  """
  alias VaccinationApi.Core.Vaccine
  alias VaccinationApi.Utils
  import Happy

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_name {:ok, name} = Utils.get_param(params, "name")
      @params_lot {:ok, lot} = Utils.get_param(params, "lot")
      @params_expiration_date {:ok, expiration_date} = Utils.get_param(params, "expiration_date")

      # @granted_authed true = authed.id == vaccine_id

      {:ok, vaccine} =
        Vaccine.Api.insert(params)
        |> Utils.visible_fields(permission)

      {:ok, vaccine}
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
      @params_vaccine_id {:ok, vaccine_id} = Utils.get_param(params, "vaccine_id")

      @vaccine {:ok, vaccine} = Vaccine.Api.get(vaccine_id)

      # @granted_authed true = authed.id == vaccine_id

      {:ok, vaccine}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    Vaccine.Api.all(select: Vaccine.bee_permission(permission))
  end

  def patch(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_vaccine_id {:ok, vaccine_id} = Utils.get_param(params, "vaccine_id")
      @vaccine {:ok, vaccine} = Vaccine.Api.get(vaccine_id)

      # @granted_authed true = authed.id == vaccine_id

      Vaccine.Api.update(vaccine, params)
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
      @params_vaccine_id {:ok, vaccine_id} = Utils.get_param(params, "vaccine_id")
      @vaccine {:ok, vaccine} = Vaccine.Api.get(vaccine_id)

      # @granted_authed true = authed.id == vaccine_id

      Vaccine.Api.delete(vaccine)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
