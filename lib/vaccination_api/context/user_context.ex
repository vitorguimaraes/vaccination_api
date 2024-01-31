defmodule VaccinationApi.UserContext do
  @moduledoc """
    Context of user functions
  """
  alias VaccinationApi.Core.User
  alias VaccinationApi.Utils
  import Happy

  @doc """
    Authenticates user access
    params:
      - email
      - password
  """
  def authenticate_access(params) do
    happy_path do
      # required params
      @param_email {:ok, email} = Utils.get_param(params, "email")
      @param_password {:ok, password} = Utils.get_param(params, "password")

      @user {:ok, user} = User.Api.get_by(where: [email: email])

      @password true = User.Api.check_password(user, password)
      {:ok, user}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:password, false} -> {:error, "email_or_password_invalid"}
    end
  end

  def create(params) do
    permission = Access.get(params, "permission") || :basic

    happy_path do
      # required params
      @params_username {:ok, username} = Utils.get_param(params, "username")
      @params_email {:ok, email} = Utils.get_param(params, "email")
      @params_password {:ok, password} = Utils.get_param(params, "password")

      insert_params = %{
        username: username,
        email: email,
        __password__: password
      }

      {:ok, user} =
        User.Api.insert(insert_params)
        |> Utils.visible_fields(permission)

      {:ok, user}
    else
      {atom, {:error, error}} -> {:error, "#{atom}_#{error}"}
      {:error, error} -> {:error, error}
    end
  end
end
