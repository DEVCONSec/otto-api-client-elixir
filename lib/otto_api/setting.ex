defmodule OttoApi.Setting do
  @enforce_keys [:key, :value]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, key: binary, value: binary, inserted_at: binary})}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/settings")

    settings =
      Enum.map(records, fn record ->
        %{"id" => id, "key" => key, "value" => value, "inserted_at" => inserted_at} =
          record

        %__MODULE__{id: id, key: key, value: value, inserted_at: inserted_at}
      end)

    {:ok, settings}
  end

  def create(client, setting_attributes) do
    {:ok, %{"data" => setting_attributes}}= Client.post(client, "/settings", %{"setting" => setting_attributes})

    {:ok,
     %__MODULE__{
       id: setting_attributes["id"],
       key: setting_attributes["key"],
       value: setting_attributes["value"],
       inserted_at: setting_attributes["inserted_at"]
     }}
  end

  def update(client, setting_attributes) do
    {:ok, %{"data" => setting_attributes}}= Client.put(client, "/settings", %{"setting" => setting_attributes})

    {:ok,
     %__MODULE__{
       id: setting_attributes["id"],
       key: setting_attributes["key"],
       value: setting_attributes["value"],
       inserted_at: setting_attributes["inserted_at"]
     }}
  end


  def delete(client, id) do
    {:ok, _}= Client.delete(client, "/settings", %{"id" => id})

    {:ok, id}
  end
end
