defmodule OttoApi.Account do
  @enforce_keys [:name, :description]
  defstruct @enforce_keys ++ [:id, :inserted_at]

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

  def create(client, account_attributes) do
    result = Client.post(client, "/accounts", %{"account" => account_attributes})
raise inspect(result) #HACK FIXME
    {:ok, %{"data" => account_attributes}} = Client.post(client, "/accounts", %{"account" => account_attributes})

    {:ok,
     %__MODULE__{
       id: account_attributes["id"],
       name: account_attributes["name"],
       description: account_attributes["description"],
       inserted_at: account_attributes["inserted_at"]
     }}
  end
end
