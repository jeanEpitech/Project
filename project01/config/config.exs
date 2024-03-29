# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :project01,
  ecto_repos: [Project01.Repo]

# Configures the endpoint
config :project01, Project01Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yWWOWLqMB2l3xhLZICbC0ddC0nWWZ3NObhjNSimhhBi0Rk6RyHsyyV8SMtCjzlVM",
  render_errors: [view: Project01Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Project01.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
