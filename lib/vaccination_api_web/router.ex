defmodule VaccinationApiWeb.Router do
  use VaccinationApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {VaccinationApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug VaccinationApiWeb.Auth.Pipeline
  end

  pipeline :authed do
    plug VaccinationApiWeb.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", VaccinationApiWeb do
    pipe_through [:api]

    get "/", PageController, :health_check
  end

  scope "/api", VaccinationApiWeb do
    pipe_through [:api]

    # user
    post "/users", UsersController, :create

    # authenticate
    scope "/auth" do
      post "/login", AuthController, :login

      scope "/" do
        pipe_through [:authed]
        post "/logout", AuthController, :logout
      end
    end

    # person
    scope "/" do
      pipe_through [:authed]

      post "/persons", PersonsController, :create
      get "/persons/:person_id", PersonsController, :one
      get "/persons", PersonsController, :all
      patch "/persons/:person_id", PersonsController, :patch
      delete "/persons/:person_id", PersonsController, :delete

      # person vaccinations
      get "/persons/:person_id/vaccinations/:vaccination_id", VaccinationsController, :one_by_person
      get "/persons/:person_id/vaccinations", VaccinationsController, :all_by_person
    end

    scope "/" do
      pipe_through [:authed]

      post "/health_professionals", HealthProfessionalsController, :create
      get "/health_professionals/:health_professional_id", HealthProfessionalsController, :one
      get "/health_professionals", HealthProfessionalsController, :all
      patch "/health_professionals/:health_professional_id", HealthProfessionalsController, :patch
      delete "/health_professionals/:health_professional_id", HealthProfessionalsController, :delete

      # health_professional vaccinations
      post "/health_professionals/:health_professional_id/persons/:person_id/vaccinations", VaccinationsController, :create
      get "/health_professionals/:health_professional_id/vaccinations/:vaccination_id", VaccinationsController, :one_by_professional
      get "/health_professionals/:health_professional_id/vaccinations", VaccinationsController, :all_by_professional
      patch "/health_professionals/:health_professional_id/vaccinations/:vaccination_id", VaccinationsController, :patch
    end

    scope "/" do
      pipe_through [:authed]

      post "/vaccinations", VaccinationsController, :create
      get "/vaccinations", VaccinationsController, :all
      patch "/vaccinations/:vaccine_id", VaccinationsController, :patch
      delete "/vaccinations/:vaccine_id", VaccinationsController, :delete
    end

    scope "/" do
      pipe_through [:authed]

      post "/health_centers", HealthCentersController, :create
      get "/health_centers/:health_center_id", HealthCentersController, :one
      get "/health_centers", HealthCentersController, :all
      patch "/health_centers/:health_center_id", HealthCentersController, :patch
      delete "/health_centers/:health_center_id", HealthCentersController, :delete
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:vaccination_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: VaccinationApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
