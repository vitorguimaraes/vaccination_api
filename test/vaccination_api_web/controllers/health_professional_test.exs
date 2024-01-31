defmodule VaccinationApiWeb.Scenarios.HealthProfessionalRoutesTest do
  use VaccinationApiWeb.ConnCase
  alias VaccinationApi.Core.HealthProfessional

  describe "Scenarios to post api/health_professionals" do
    setup do
      scenario = Factory.HealthProfessional.create()[:health_professional]

      params = %{
        first_name: "Joe-" <> Bee.unique(10),
        last_name: "Doe-" <> Bee.unique(10),
        cpf: Brcpfcnpj.cpf_generate(),
        professional_register: "ABC123",
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

    test "POST /api/health_professionals", ctx do
      params = ctx[:params]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        authed_conn(user)
        |> post("/api/health_professionals", params)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/health_professionals/:person_id", ctx do
      health_professional = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/health_professionals/#{health_professional.id}"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/health_professionals", ctx do
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/health_professionals"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "PUT /api/health_professionals/:person_id", ctx do
      health_professional = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        patch(
          authed_conn(user),
          "/api/health_professionals/#{health_professional.id}",
          %{first_name: "Marilyn"}
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "DELETE /api/health_professionals/:person_id", ctx do
      health_professional = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        delete(
          authed_conn(user),
          "/api/health_professionals/#{health_professional.id}"
        )

      assert {:error, :not_found} = HealthProfessional.Api.get(health_professional.id)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end
  end
end
