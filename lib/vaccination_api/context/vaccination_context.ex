defmodule VaccinationApi.VaccinationContext do
  @moduledoc """
    Context of vaccination functions
  """
  alias VaccinationApi.Core.{HealthProfessional, Person, Vaccination, Vaccine}
  alias VaccinationApi.Utils
  import Happy

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_shot {:ok, shot} = Utils.get_param(params, "shot")
      @params_date {:ok, date} = Utils.get_param(params, "date")
      @params_person_id {:ok, person_id} = Utils.get_param(params, "person_id")
      @params_health_professional_id {:ok, health_professional_id} = Utils.get_param(params, "health_professional_id")
      @params_vaccine_id {:ok, vaccine_id} = Utils.get_param(params, "vaccine_id")

      @person true = Person.Api.exists?(where: [id: person_id])
      @health_professional true = HealthProfessional.Api.exists?(where: [id: health_professional_id])
      @vaccine true = Vaccine.Api.exists?(where: [id: vaccine_id])

      # @granted_authed true = authed.id == vaccination_id

      {:ok, vaccination} =
        Vaccination.Api.insert(params)
        |> Utils.visible_fields(permission)

      {:ok, vaccination}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:error, error} -> {:error, error}
    end
  end

  def one_by_professional(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_vaccination_id {:ok, vaccination_id} = Utils.get_param(params, "vaccination_id")
      @params_health_professional_id {:ok, health_professional_id} = Utils.get_param(params, "health_professional_id")

      @health_professional true = HealthProfessional.Api.exists?(where: [id: health_professional_id])
      @vaccination {:ok, vaccination} =
        Vaccination.Api.get_by(
          where: [id: vaccination_id, health_professional_id: health_professional_id],
          preload: [:persons, :health_professional, :vaccine]
        )

      # @granted_authed true = authed.id == vaccination_id

      {:ok, vaccination}
      |> Utils.visible_fields(permission)
    else
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
    end
  end

  def all(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    Vaccination.Api.all(
      select: Vaccination.bee_permission(permission)
    )
  end

  def patch(params) do
    authed = Access.get(params, "authed")
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_vaccination_id {:ok, vaccination_id} = Utils.get_param(params, "vaccination_id")
      @vaccination {:ok, vaccination} = Vaccination.Api.get(vaccination_id)

      # @granted_authed true = authed.id == vaccination_id

      Vaccination.Api.update(vaccination, params)
      |> Utils.visible_fields(permission)
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:granted_authed, false} -> {:error, "operation_not_allowed_for_this_user"}
    end
  end
end
