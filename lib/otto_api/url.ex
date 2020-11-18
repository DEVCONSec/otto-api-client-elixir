defmodule OttoApi.Url do
  @enforce_keys [:url,:site_id]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}, account_id :: binary, site_id :: binary) ::
          {:ok,
           list(%__MODULE__{id: binary, url: binary, site_id: binary, inserted_at: binary})}

  def all(client, account_id, site_id) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts/#{account_id}/sites/#{site_id}/urls")

    urls =
      Enum.map(records, fn record ->
        %{"id" => id, "url" => url, "site_id" => site_id, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, url: url, site_id: site_id, inserted_at: inserted_at}
      end)

    {:ok, urls}
  end

  def create(client, account_id, url_attributes) do
    {:ok, %{"data" => url_data}} = Client.post(client, "/accounts/#{account_id}/sites/#{url_attributes["site_id"]}/urls", %{"url" => url_attributes})

    {:ok,
     %__MODULE__{
       id: url_data["id"],
       url: url_data["url"],
       site_id: url_data["site_id"],
       inserted_at: url_data["inserted_at"]
     }}
  end
end
