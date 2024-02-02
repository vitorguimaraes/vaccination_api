defmodule VaccinationApiWeb.Scenarios.PersonRoutesTest do
  use VaccinationApiWeb.ConnCase
  alias VaccinationApi.Core.Person

  describe "Scenarios to post api/persons" do
    setup do
      scenario = Factory.Person.create()[:person]

      params = %{
        first_name: "Joe-" <> Bee.unique(10),
        last_name: "Doe-" <> Bee.unique(10),
        birth: "1998-09-27",
        cpf: Brcpfcnpj.cpf_generate(),
        sus_number: Bee.unique(15, only_numbers: true, with_zeros: true),
        mother_name: "Marlin-" <> Bee.unique(10),
        gender: "male",
        user: %{
          username: "common_user",
          email: "common_user@mail.com",
          password: "Common@123"
        }
      }

      user_params = %{
        username: "fakeuser",
        email: "fakeuser_email@mail.com",
        password: "Faker@123"
      }

      {:ok, params: params, user_params: user_params, scenario: scenario}
    end

    test "POST /api/persons", ctx do
      params = ctx[:params]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
               post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        authed_conn(user)
        |> post("/api/persons", params)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/persons/:person_id", ctx do
      person = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
               post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/persons/#{person.id}"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/persons", ctx do
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
               post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/persons"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "PUT /api/persons/:person_id", ctx do
      person = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
               post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        patch(
          authed_conn(user),
          "/api/persons/#{person.id}",
          %{first_name: "Marilyn"}
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "DELETE /api/persons/:person_id", ctx do
      person = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
               post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        delete(
          authed_conn(user),
          "/api/persons/#{person.id}"
        )

      assert {:error, :not_found} = Person.Api.get(person.id)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end
  end
end
