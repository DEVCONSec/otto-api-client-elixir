defmodule OttoApi.Url do
  @enforce_keys [:url, :site_id]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, url: binary, account_id: binary, inserted_at: binary})}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/urls")

    urls =
      Enum.map(records, fn record ->
        %{"id" => id, "url" => url, "site_id" => site_id, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, url: url, site_id: site_id, inserted_at: inserted_at}
      end)

    {:ok, urls}
  end

  def create(client, site_attributes) do
    {:ok, %{"data" => site_attributes}} = Client.post(client, "/urls", %{"url" => site_attributes})

    {:ok,
     %__MODULE__{
       id: site_attributes["id"],
       url: site_attributes["url"],
       site_id: site_attributes["site_id"],
       inserted_at: site_attributes["inserted_at"]
     }}
  end
end
