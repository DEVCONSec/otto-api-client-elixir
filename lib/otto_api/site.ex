defmodule OttoApi.Site do
  @enforce_keys [:url, :account_id]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, url: binary, account_id: binary, inserted_at: binary})}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/sites")

    accounts =
      Enum.map(records, fn record ->
        %{"id" => id, "url" => url, "account_id" => account_id, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, url: url, account_id: account_id, inserted_at: inserted_at}
      end)

    {:ok, accounts}
  end

  def create(client, site) do
    {:ok, _response} = Client.post(client, "/sites", %{"site" => Map.from_struct(site)})
  end
end
