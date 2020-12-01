defmodule OttoApi.Alert do
  @enforce_keys [:site_id]
  defstruct @enforce_keys ++ [:id, :alert_type_id, :alert_type, :summary, :detail, :alert_count, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}, account_id :: binary, site_id :: binary) ::
          {:ok, list(%__MODULE__{id: binary, site_id: binary, alert_type: %{ id: binary, name: binary, description: binary, severity: binary}, summary: binary, detail: %{ description: binary, origin: binary, destination: binary }, alert_count: list, inserted_at: binary})}

  def all(client, account_id, site_id) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/alerts")

    alerts =
      Enum.map(records, fn record ->
        %{"id" => id,
          "site_id" => site_id,
          "alert_type" => %{
            "id" => alert_type_id,
            "name" => alert_type_name,
            "description" => alert_type_description,
            "severity" => alert_type_severity
          },
          "summary" => alert_summary,
          "detail" => %{
            "description" => description,
            "origin" => detail_origin,
            "destination" => detail_destination
          },
          "alert_count"=> alert_count,
          "inserted_at"=>inserted_at
        } = record

        %__MODULE__{
          id: id,
          site_id: site_id,
          summary: alert_summary,
          alert_type: %{ id: alert_type_id, name: alert_type_name, description: alert_type_description, severity: alert_type_severity},
          detail: %{ description: description, origin: detail_origin, destination: detail_destination },
          alert_count: alert_count,
          inserted_at: inserted_at
        }
      end)

    {:ok, alerts}
  end


end
