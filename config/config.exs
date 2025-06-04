# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :warwavex_chan,
  ecto_repos: [WarwavexChan.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :warwavex_chan, WarwavexChan.Mailer, adapter: Swoosh.Adapters.Local

config :warwavex_chan_web,
  ecto_repos: [WarwavexChan.Repo],
  generators: [context_app: :warwavex_chan]

# Configures the endpoint
config :warwavex_chan_web, WarwavexChanWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: WarwavexChanWeb.ErrorHTML, json: WarwavexChanWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: WarwavexChan.PubSub,
  live_view: [signing_salt: "xwzYIIDB"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  warwavex_chan_web: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/warwavex_chan_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.0.9",
  warwavex_chan_web: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("../apps/warwavex_chan_web", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
