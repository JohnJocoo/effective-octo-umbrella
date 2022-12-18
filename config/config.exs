# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :marley,
  ecto_repos: [Marley.Repo]

# Configures the endpoint
config :marley, MarleyWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MarleyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Marley.PubSub,
  live_view: [signing_salt: "gcUgKtkK"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :marley, Marley.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
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

secrets_file = "config/#{config_env()}.secrets.exs"
if File.exists?(secrets_file) do
  import_config "#{config_env()}.secrets.exs"
else
  if config_env() != "test" do
    IO.puts(
      IO.ANSI.yellow() <>
      "[warning] #{secrets_file} config file doesn't exist. Did you forget to decrypt secrets?" <>
      IO.ANSI.reset()
    )
  end
end

config :secrex,
  files: ["config/prod.secrets.exs", "config/dev.secrets.exs"]
