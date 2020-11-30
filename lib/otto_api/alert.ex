defmodule OttoApi.Alert do
  @enforce_keys [:site_id]
  defstruct @enforce_keys ++ [:id, :inserted_at, :alert_type_id, :description]

  alias OttoApi.Client

  @spec all(client :: %Client{}, account_id :: binary, site_id :: binary) ::
          {:ok, list(%__MODULE__{id: binary, site_id: binary, alert_type_id: binary, description: binary, inserted_at: binary})}

  def all(client, account_id, site_id) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/alerts")

    alerts =
      Enum.map(records, fn record ->
        %{"id" => id, "site_id" => site_id, "alert_type_id" => alert_type_id, "description" => description, "inserted_at" => inserted_at} = record

        %__MODULE__{id: id,  site_id: site_id, alert_type_id: alert_type_id, description: description, inserted_at: inserted_at}
      end)

    {:ok, alerts}
  end


end
