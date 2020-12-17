defmodule OttoApi.NetworkExposureAggregation do
  @enforce_keys [:unique_clients, :count, :unique_desktop, :unique_mobile]
  defstruct @enforce_keys ++ []

  alias OttoApi.Client

  @spec get(
          client :: %Client{},
          account_id :: binary(),
          site_id :: binary(),
          incident_id :: binary()
        ) ::
          {:ok,
           %__MODULE__{
             unique_clients: integer,
             count: integer,
             unique_desktop: integer,
             unique_mobile: integer
           }}

  def get(client, account_id, site_id, request_id) do
    {:ok,
     %{
       "data" => record
     }} =
      Client.get(
        client,
        "/accounts/#{account_id}/sites/#{site_id}/network_requests/#{request_id}/exposure_aggregations"
      )

    %{
      "unique_clients" => unique_clients,
      "count" => count,
      "unique_desktop" => unique_desktop,
      "unique_mobile" => unique_mobile
    } = record

    {:ok,
     %__MODULE__{
       unique_clients: unique_clients,
       count: count,
       unique_desktop: unique_desktop,
       unique_mobile: unique_mobile
     }}
  end

end
