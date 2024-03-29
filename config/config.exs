# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :vaccination_api, :swagger,
  host: "localhost",
  port: 4000,
  scheme: "http",
  base_module: "VaccinationApi",
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: VaccinationApiWeb.Router
    ]
  }

config :vaccination_api, swagger_json_library: Jason

config :vaccination_api,
  ecto_repos: [VaccinationApi.Repo]

config :vaccination_api, VaccinationApi.Repo, migration_primary_key: [type: :binary_id]

# Configures the endpoint
config :vaccination_api, VaccinationApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: VaccinationApiWeb.ErrorHTML, json: VaccinationApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: VaccinationApi.PubSub,
  live_view: [signing_salt: "mdfLLQ+j"]

config :vaccination_api, VaccinationApiWeb.Auth,
  issuer: "vaccination_api",
  secret_key: "7AV+0lMwQYHdjiPlbu0fcpYlD1g9ooJsYH20LRdDaqrkU/WRokgBixM/TQpi0K3S"

config :bee, :repo, VaccinationApi.Repo

config :vaccination_api, Oban,
  repo: VaccinationApi.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :vaccination_api, VaccinationApi.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
