defmodule VaccinationApi.Utils do
  @moduledoc """
    Set of common functions to use in VaccinationApi app
  """

  @doc """
    Get param
  """
  def get_param(params, param) do
    case Access.fetch(params, param) do
      {:ok, param} -> {:ok, param}
      :error -> {:error, :not_found}
    end
  end

  @doc """
    Remove nil fields
  """
  def remove_nil_fields(params) do
    for({key, value} <- params, !is_nil(value) && value != "nil", into: %{}, do: {key, value})
  end

  @doc """
    return only visible fields, permission based
  """
  def visible_fields({:error, error}, _permission), do: {:error, error}

  def visible_fields({:ok, %{__struct__: entity} = model}, permission) do
    {:ok, Map.take(model, entity.bee_permission(permission))}
  end

  def visible_fields(%{__struct__: entity} = model, permission) do
    Map.take(model, entity.bee_permission(permission))
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
