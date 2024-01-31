defmodule Factory.HealthProfessional do
  @moduledoc """
    Functions to create health_professionals on various scenarios
  """
  alias Factory.Base

  @doc """
    Creates a health_professional
  """
  def create(map \\ %{}, attrs \\ %{}, opts \\ []) do
    tag = opts[:tag] || :health_professional

    health_professional =
      attrs
      |> Factory.health_professional()

      Map.put(map, tag, health_professional)
  end
end
