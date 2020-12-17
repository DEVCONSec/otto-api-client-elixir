defmodule OttoApi.NetworkRequest do
  @enforce_keys [
    :hostname,
    :url,
    :path,
    :initiator,
    :request_type,
    :site_id,
    :severity,
    :ignored,
    :resolved,
    :blocked,
    :is_blocked,
    :first_seen,
    :last_seen
  ]
  defstruct @enforce_keys ++ [:id, :url_found_on]

  alias OttoApi.Client

  @spec all(client :: %Client{}, account_id :: binary(), site_id :: binary()) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             hostname: string,
             url: string,
             path: string,
             initiator: string,
             request_type: string,
             site_id: string,
             severity: integer,
             ignored: boolean,
             resolved: boolean,
             blocked: boolean,
             is_blocked: boolean,
             first_seen: binary,
             url_found_on: binary,
             last_seen: binary
           })}

  def all(client, account_id, site_id) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/network_requests")

    network_requests =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "hostname" => hostname,
          "url" => url,
          "path" => path,
          "initiator" => initiator,
          "request_type" => request_type,
          "severity" => severity,
          "ignored" => ignored,
          "resolved" => resolved,
          "blocked" => blocked,
          "is_blocked" => is_blocked,
          "first_seen" => first_seen,
          "url_found_on" => url_found_on,
          "last_seen" => last_seen
        } = record

        %__MODULE__{
          id: id,
          hostname: hostname,
          url: url,
          path: path,
          initiator: initiator,
          request_type: request_type,
          site_id: site_id,
          severity: severity,
          ignored: ignored,
          resolved: resolved,
          blocked: blocked,
          is_blocked: is_blocked,
          first_seen: first_seen,
          url_found_on: url_found_on,
          last_seen: last_seen
        }
      end)

    {:ok, network_requests}
  end

  def get(client, account_id, site_id, network_request_id) do
    {:ok,
     %{
       "data" => record
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/network_requests/#{network_request_id}")


    %{
      "id" => id,
      "hostname" => hostname,
      "url" => url,
      "path" => path,
      "initiator" => initiator,
      "request_type" => request_type,
      "severity" => severity,
      "ignored" => ignored,
      "resolved" => resolved,
      "blocked" => blocked,
      "is_blocked" => is_blocked,
      "first_seen" => first_seen,
      "url_found_on" => url_found_on,
      "last_seen" => last_seen
    } = record

    network_request = %__MODULE__{
      id: id,
          hostname: hostname,
          url: url,
          path: path,
          initiator: initiator,
          request_type: request_type,
          severity: severity,
          site_id: site_id,
          ignored: ignored,
          resolved: resolved,
          blocked: blocked,
          is_blocked: is_blocked,
          first_seen: first_seen,
          url_found_on: url_found_on,
          last_seen: last_seen
    }

    {:ok, network_request}
  end
end
