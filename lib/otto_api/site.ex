defmodule OttoApi.Site do
  @enforce_keys [:url, :account_id]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, url: binary, name: binary, account_id: binary, inserted_at: binary})}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/sites")

    accounts =
      Enum.map(records, fn record ->
        %{"id" => id, "url" => url, "name" => name,  "account_id" => account_id, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, url: url, name: name, account_id: account_id, inserted_at: inserted_at}
      end)

    {:ok, accounts}
  end

  def create(client, site_attributes) do
    {:ok, %{"data" => site_attributes}} = Client.post(client, "/sites", %{"site" => site_attributes})

    {:ok,
     %__MODULE__{
       id: site_attributes["id"],
       url: site_attributes["url"],
       name: site_attributes["name"],
       account_id: site_attributes["account_id"],
       inserted_at: site_attributes["inserted_at"]
     }}
  end
end
