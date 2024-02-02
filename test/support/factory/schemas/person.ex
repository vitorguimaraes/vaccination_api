defmodule Factory.Person do
  @moduledoc """
    Functions to create persons on various scenarios
  """
  alias Factory.Base

  @doc """
    Creates a person
  """
  def create(map \\ %{}, attrs \\ %{}, opts \\ []) do
    tag = opts[:tag] || :person

    person =
      attrs
      |> Factory.person()

    Map.put(map, tag, person)
  end
end
