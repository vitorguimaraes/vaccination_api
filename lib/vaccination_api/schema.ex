defmodule VaccinationApi.Schema do
  @moduledoc """
    VaccinationApi Schema
  """
  defmacro __using__(_) do
    quote do
      use Bee.Schema,
        foreign_key_type: :binary_id,
        primary_key: {:id, :binary_id, autogenerate: true},
        timestamp_opts: [type: :utc_datetime]

      use Ecto.Schema

      @timestamps_opts [type: :utc_datetime]
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      import Ecto.Changeset
      import VaccinationApi.Schema
    end
  end

  def get_in_(opts, keys, default \\ nil) do
    get_in(opts, keys) || default
  rescue
    _ -> default
  end

  def put_in_(map, _key, nil), do: map

  def put_in_(map, key, value) do
    Map.put(map, key, value)
  end

  def associated_schema(%schema{}, assoc), do: associated_schema(schema, assoc)

  def associated_schema(schema, assoc) do
    schema.__schema__(:association, assoc)
    |> case do
      %{related: assoc_schema} -> assoc_schema
      _ -> {:error, :inexistent_association}
    end
  end

  @doc """
    Reload a entity
  """
  def reload(%schema{id: id}, opts \\ []),
    do: Module.concat([schema, Api]).get(id, opts)
end
