defmodule VaccinationApiWeb.Scenarios.VaccineRoutesTest do
  use VaccinationApiWeb.ConnCase
  alias VaccinationApi.Core.Vaccine

  describe "Scenarios to post api/vaccines" do
    setup do
      scenario = Factory.Vaccine.create()[:vaccine]

      params = %{
        name: "Pfizer-" <> Bee.unique(10),
        lot: "XYZ123456",
        expiration_date: "2025-09-23"
      }

      user_params = %{
        username: "fakeuser",
        email: "fakeuser_email@mail.com",
        password: "Faker@123"
      }

      {:ok, params: params, user_params: user_params, scenario: scenario}
    end

    test "POST /api/vaccines", ctx do
      params = ctx[:params]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        authed_conn(user)
        |> post("/api/vaccines", params)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/vaccines/:vaccine_id", ctx do
      vaccine = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/vaccines/#{vaccine.id}"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "GET /api/vaccines", ctx do
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        get(
          authed_conn(user),
          "/api/vaccines"
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "PUT /api/vaccines/:vaccine_id", ctx do
      vaccine = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        patch(
          authed_conn(user),
          "/api/vaccines/#{vaccine.id}",
          %{first_name: "Marilyn"}
        )

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end

    test "DELETE /api/vaccines/:vaccine_id", ctx do
      vaccine = ctx[:scenario]
      user_params = ctx[:user_params]

      assert %{"data" => %{"id" => _id} = user} =
        post(anonymous_conn(), "/api/users", user_params) |> get_resp_body()

      conn =
        delete(
          authed_conn(user),
          "/api/vaccines/#{vaccine.id}"
        )

      assert {:error, :not_found} = Vaccine.Api.get(vaccine.id)

      response = get_resp_body(conn)

      assert %{"message" => "ok"} = response
      assert %{"details" => ["ok"]} = response
      assert 200 = conn.status
    end
  end
end
