defmodule Factory.Vaccine do
  @moduledoc """
    Functions to create vaccines on various scenarios
  """
  alias Factory.Base

  @doc """
    Creates a vaccine
  """
  def create(map \\ %{}, attrs \\ %{}, opts \\ []) do
    tag = opts[:tag] || :vaccine

    vaccine =
      attrs
      |> Factory.vaccine()

      Map.put(map, tag, vaccine)
  end
end
