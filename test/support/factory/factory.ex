defmodule Factory do
  @moduledoc """
    This module configure default for all schemas for Factory tests
  """
  alias VaccinationApi.Core.{HealthProfessional, Person, Vaccine}
  alias VaccinationApi.Repo

  @doc """
    Creates a person
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
      gender: "male"
    }
    |> merge_attributes(attrs, Person, opts)
  end

  @doc """
    Creates a health_professional
  """
  def health_professional(attrs \\ %{}, opts \\ []) do
    %{
      id: Ecto.UUID.generate(),
      first_name: "Joe-" <> Bee.unique(10),
      last_name: "Doe-" <> Bee.unique(10),
      cpf: Brcpfcnpj.cpf_generate(),
      professional_register: "REGISTER-" <> Bee.unique(15)
    }
    |> merge_attributes(attrs, HealthProfessional, opts)
  end

  @doc """
    Creates a vaccine
  """
  def vaccine(attrs \\ %{}, opts \\ []) do
    %{
      id: Ecto.UUID.generate(),
      name: "Pfizer-" <> Bee.unique(10),
      lot: "XYZ-" <> Bee.unique(10),
      expiration_date: "2025-09-23"
    }
    |> merge_attributes(attrs, Vaccine, opts)
  end

  def merge_attributes(src, attrs, struct_, opts) do
    attributes = Map.merge(src, attrs)

    if opts[:only_map] do
      Map.merge(src, attrs)
    else
      struct(struct_)
      |> struct_.changeset_insert(attributes)
      |> Repo.insert!()
    end
  end

  def merge_attributes(src, attrs, struct_) do
    attributes = Map.merge(src, attrs)

    struct(struct_)
    |> struct_.changeset(attributes)
    |> Repo.insert!()
  end
end
