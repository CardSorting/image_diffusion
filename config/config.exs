# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :image_diffusion,
  ecto_repos: [ImageDiffusion.Repo]

# Configures the endpoint
config :image_diffusion, ImageDiffusionWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ImageDiffusionWeb.ErrorHTML, json: ImageDiffusionWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ImageDiffusion.PubSub,
  live_view: [signing_salt: "YnkmM9Js"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :image_diffusion, ImageDiffusion.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :ex_aws,
  access_key_id: System.get_env("AKIAXH5DBMF4KV7RF3DX"),
  secret_access_key: System.get_env("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"),
  region: System.get_env("AWS_REGION") || "us-east-1"
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
  config :waffle,
  storage: Waffle.Storage.S3,
  bucket: System.get_env("S3_IMAGE_BUCKET"),
  asset_host: {:system, "S3_ASSET_HOST"}
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
import_config "#{Mix.env()}.env"
