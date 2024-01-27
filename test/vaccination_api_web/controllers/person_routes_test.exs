defmodule VaccinationApiWeb.Scenarios.PersonRoutesTest do
  use VaccinationApiWeb.ConnCase
  alias VaccinationApi.Core.Person

  describe "Scenarios to post api/persons" do
    setup do
      params = %{
        first_name: "Joe-" <> Bee.unique(10),
        last_name: "Doe-" <> Bee.unique(10),
        birth: "1998-09-27",
        cpf: Brcpfcnpj.cpf_generate(),
        sus_number: Bee.unique(15, only_numbers: true, with_zeros: true),
        mother_name: "Marlin-" <> Bee.unique(10),
        gender: "male",
        email: "email-#{Bee.unique(10)}@teste.com.br",
        password: "J@d" <> Bee.unique(9)
      }

      {:ok, params: params}
    end

    test "POST /api/persons", ctx do
      params = ctx[:params]

      conn =
        post(
          anonymous_conn(),
          "/api/persons",
          params
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 201 = conn.status
    end
  end
end
