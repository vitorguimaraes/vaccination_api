defmodule Factory do
  @moduledoc """
    This module configure default for all schemas for Factory tests
  """
  alias VaccinationApi.Core.Person
  alias VaccinationApi.Repo

  @doc """
    creates a person with minimum requirement
  """
  def person(attrs \\ %{}, opts \\ []) do
    %{
      id: Ecto.UUID.generate(),
      first_name: "Joe-" <> Bee.unique(10),
      last_name: "Doe-" <> Bee.unique(10),
      birth: "1998-09-27",
      cpf: Brcpfcnpj.cpf_generate(),
      sus_number: Bee.unique(15, only_numbers: true, with_zeros: true),
      mother_name: "Marlin-" <> Bee.unique(10),
      gender: "male",
      email: "email-#{Bee.unique(10)}@teste.com.br",
      password: "J@d" <> Bee.unique(5)
    }
    |> merge_attributes(attrs, Person, opts)
  end

  def merge_attributes(src, attrs, struct_, opts) do
    attributes = Map.merge(src, attrs)

    if opts[:only_map] do
      Map.merge(src, attrs)
    else
      struct(struct_)
      |> struct_.changeset_factory(attributes)
      |> Repo.insert!()
    end
  end

end
