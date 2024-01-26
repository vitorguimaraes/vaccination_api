defmodule VaccinationApi.Utils do
  @moduledoc """
    Set of common functions to use in VaccinationApi app
  """

  @doc """
    Get param
  """
  def get_param(params, param) do
    Access.fetch(params, param)
  end

  def validate_cpf(%{changes: params} = model) do
    cpf = params[:cpf]

    cond do
      Brcpfcnpj.cpf_valid?(cpf) == false ->
        Ecto.Changeset.add_error(model, :cpf, "cpf is invalid")

      :else ->
        model
    end
  end

  def put_password_hash(%{changes: %{__password__: password}} = changeset) do
    if password && changeset.valid? do
      changeset
      |> validate_length(:__password__, min: 8, message: "Password must be at least eight characters")
      |> validate_format(:__password__, ~r/[0-9]+/, message: "Password must contain a number")
      |> validate_format(:__password__, ~r/[A-Z]+/, message: "Password must contain an upper-case letter")
      |> validate_format(:__password__, ~r/[a-z]+/, message: "Password must contain a lower-case letter")
      |> validate_format(:__password__, ~r/[#\!\?&@\$%^&*\(\)]+/, message: "Password must contain a symbol")
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:__password__)
    else
      changeset
    end
  end

  @doc """
    Parse changeset error
  """
  def parse_changeset(changeset),
    do: parse_changeset_error(changeset) |> List.flatten() |> Map.new()

  defp parse_changeset_error(%Ecto.Changeset{changes: changes, errors: errors}) do
    changes =
      changes
      |> Enum.map(fn {_key, value} -> parse_changeset_error(value) end)
      |> List.flatten()

    errors =
      errors
      |> Enum.map(fn {key, {value, _}} -> {key, value} end)

    List.flatten(errors ++ changes)
  end

  defp parse_changeset_error(_), do: []
end
