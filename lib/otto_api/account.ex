defmodule OttoApi.Account do
  @enforce_keys [:id, :name, :description, :inserted_at]
  defstruct @enforce_keys

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, name: binary, description: binary, inserted_at: binary})}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/accounts")

    accounts =
      Enum.map(records, fn record ->
        %{"id" => id, "name" => name, "description" => description, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, name: name, description: description, inserted_at: inserted_at}
      end)

    {:ok, accounts}
  end

  def create(client, account) do
    {:ok, response} = Client.post(client, "/accounts", %{"account" => Map.from_struct(account)})
  end
end
