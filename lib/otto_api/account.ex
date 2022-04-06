defmodule OttoApi.Account do
  @enforce_keys [:name, :description]
  defstruct @enforce_keys ++ [:id, :inserted_at, :referral_source]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, name: binary, description: binary, inserted_at: binary})}
  def all(client) do
    case Client.get(client, "/accounts") do
      {:ok, %{"data" => records}} ->
        accounts =
          Enum.map(records, fn record ->
            %{
              "id" => id,
              "name" => name,
              "description" => description,
              "inserted_at" => inserted_at
            } = record

            %__MODULE__{id: id, name: name, description: description, inserted_at: inserted_at}
          end)

        {:ok, accounts}

      {:error, details} ->
        {:error, details}
    end
  end

  def create(client, account_attributes) do
    case Client.post(client, "/accounts", %{"account" => account_attributes}) do
      {:ok, %{"data" => account_attributes}} ->
        {:ok,
         %__MODULE__{
           id: account_attributes["id"],
           name: account_attributes["name"],
           description: account_attributes["description"],
           inserted_at: account_attributes["inserted_at"]
         }}

      anything_else ->
        anything_else
    end
  end

  def update(client, account_id, account_attributes) do
    case Client.post(client, "/accounts/#{account_id}", %{"account" => account_attributes}) do
      {:ok, %{"data" => account_attributes}} ->
        {:ok,
         %__MODULE__{
           id: account_attributes["id"],
           name: account_attributes["name"],
           description: account_attributes["description"],
           inserted_at: account_attributes["inserted_at"]
         }}

      anything_else ->
        anything_else
    end
  end
end
