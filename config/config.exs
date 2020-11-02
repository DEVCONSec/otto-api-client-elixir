use Mix.Config

config :otto_api,
  http_client: OttoApi.Http.Client

import_config "#{Mix.env()}.exs"
