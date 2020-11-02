defmodule OttoApi.Status do
  @enforce_keys [:build_info, :uptime_seconds, :utc_now, :utc_service_start, :version]
  defstruct @enforce_keys

  defmodule BuildInfo do
    @enforce_keys [
      :app_version,
      :build_date_time,
      :build_hash,
      :build_number,
      :build_tag,
      :org_name,
      :repo_name
    ]
    defstruct @enforce_keys
  end

  alias OttoApi.Client

  def get(client) do
    {:ok,
     %{
       "data" => %{
         "build_info" => build_info,
         "uptime_seconds" => uptime_seconds,
         "utc_now" => utc_now,
         "utc_service_start" => utc_service_start,
         "version" => version
       }
     }} = Client.get(client, "/status")

    {:ok,
     %__MODULE__{
       build_info: %BuildInfo{
         app_version: build_info["app_version"],
         build_date_time: build_info["build_date_time"],
         build_hash: build_info["build_hash"],
         build_number: build_info["build_number"],
         build_tag: build_info["build_tag"],
         org_name: build_info["org_name"],
         repo_name: build_info["repo_name"]
       },
       uptime_seconds: uptime_seconds,
       utc_now: utc_now,
       utc_service_start: utc_service_start,
       version: version
     }}
  end
end
