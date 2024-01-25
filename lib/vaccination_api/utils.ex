defmodule VaccinationApi.Utils do
  @moduledoc """
    Set of common functions to use in VaccinationApi app
  """

  def validate_cpf(%{changes: params} = model) do
    cpf = params[:cpf]

    cond do
      Brcpfcnpj.cpf_valid?(cpf) == false ->
        Ecto.Changeset.add_error(model, :cpf, "cpf is invalid")

      :else ->
        model
    end
  end
end
