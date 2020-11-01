defmodule OttoApi.Account do
  @enforce_keys [:id, :name, :description, :inserted_at]
  defstruct @enforce_keys


  alias OttoApi.Client
  def all(client) do
    {:ok, %{"data" => [%{"id" =>  id, "name" => name, "description" => description, "inserted_at" => inserted_at}]}} = Client.get(client, "/accounts")
    {:ok, %__MODULE__{id: id, name: name, description: description, inserted_at: inserted_at}}
  end
end