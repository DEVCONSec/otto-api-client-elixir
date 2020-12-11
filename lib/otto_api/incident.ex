defmodule OttoApi.Incident do
  @enforce_keys [
    :account_id,
    :site_id,
    :threat_id,
    :dom_location,
    :event_name,
    :ignored,
    :resolved,
    :blocked,
    :is_blocked,
    :stack_trace,
    :url_found_on,
    :source_code,
    :first_seen,
    :last_seen
  ]
  defstruct @enforce_keys ++ [:id]

  alias OttoApi.Client

  @spec all(client :: %Client{}, account_id :: binary(), site_id :: binary()) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             account_id: binary,
             site_id: binary,
             threat_id: binary,
             dom_location: string,
             event_name: string,
             ignored: boolean,
             resolved: boolean,
             blocked: boolean,
             is_blocked: boolean,
             stack_trace: string,
             url_found_on: string,
             source_code: string,
             first_seen: binary,
             last_seen: binary
           })}

  def all(client, account_id, site_id) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/incidents")

    incidents =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "account_id" => account_id,
          "site_id" => site_id,
          "threat_id" => threat_id,
          "dom_location" => dom_location,
          "event_name" => event_name,
          "ignored" => ignored,
          "resolved" => resolved,
          "blocked" => blocked,
          "is_blocked" => is_blocked,
          "stack_trace" => stack_trace,
          "url_found_on" => url_found_on,
          "source_code" => source_code,
          "first_seen" => first_seen,
          "last_seen" => last_seen
        } = record

        %__MODULE__{
          id: id,
          account_id: account_id,
          site_id: site_id,
          threat_id: threat_id,
          dom_location: dom_location,
          event_name: event_name,
          ignored: ignored,
          resolved: resolved,
          blocked: blocked,
          is_blocked: is_blocked,
          stack_trace: stack_trace,
          url_found_on: url_found_on,
          source_code: source_code,
          first_seen: first_seen,
          last_seen: last_seen
        }
      end)

    {:ok, incidents}
  end

  def get(client, account_id, site_id, incident_id) do
    {:ok,
     %{
       "data" => record
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/incidents/#{incident_id}")


    %{
      "id" => id,
      "account_id" => account_id,
      "site_id" => site_id,
      "threat_id" => threat_id,
      "dom_location" => dom_location,
      "event_name" => event_name,
      "ignored" => ignored,
      "resolved" => resolved,
      "blocked" => blocked,
      "is_blocked" => is_blocked,
      "stack_trace" => stack_trace,
      "url_found_on" => url_found_on,
      "source_code" => source_code,
      "first_seen" => first_seen,
      "last_seen" => last_seen
    } = record

    incident = %__MODULE__{
      id: id,
      account_id: account_id,
      site_id: site_id,
      threat_id: threat_id,
      dom_location: dom_location,
      event_name: event_name,
      ignored: ignored,
      resolved: resolved,
      blocked: blocked,
      is_blocked: is_blocked,
      stack_trace: stack_trace,
      url_found_on: url_found_on,
      source_code: source_code,
      first_seen: first_seen,
      last_seen: last_seen
    }

    {:ok, incident}
  end
end
