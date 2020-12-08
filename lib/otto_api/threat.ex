defmodule OttoApi.Threat do
  @enforce_keys [:name, :description, :severity]
  defstruct @enforce_keys ++ [:id]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{id: binary, name: string, description: string, severity: integer})}

  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/threats")

    threats =
      Enum.map(records, fn record ->
        %{"id" => id, "name" => name, "description" => description, "severity" => severity} =
          record

        %__MODULE__{id: id, name: name, description: description, severity: severity}
      end)

    {:ok, threats}
  end

end
