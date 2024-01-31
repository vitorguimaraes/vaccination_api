defmodule VaccinationApiWeb.Auth.Pipeline do
  @moduledoc """
  Auth pipeline that restricts access and assigns privilege level
  """
  use Guardian.Plug.Pipeline,
    otp_app: :vaccination_api,
    module: VaccinationApiWeb.Auth,
    error_handler: VaccinationApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  # plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}
end
