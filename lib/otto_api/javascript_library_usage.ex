#
defmodule OttoApi.JavascriptLibraryUsage do
  @moduledoc """
  This model joins a javascript source file and a version of a library
  it uses.
  """
  @enforce_keys [:javascript_source_id, :javascript_library_id]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             javascript_source_id: binary,
             javascript_library_id: binary,
             inserted_at: binary
           })}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/javascript_library_usages")

    javascript_library_usages =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "javascript_source_id" => javascript_source_id,
          "javascript_library_id" => javascript_library_id,
          "inserted_at" => inserted_at
        } = record

        %__MODULE__{
          id: id,
          javascript_source_id: javascript_source_id,
          javascript_library_id: javascript_library_id,
          inserted_at: inserted_at
        }
      end)

    {:ok, javascript_library_usages}
  end

  def create(client,
        javascript_source_id: javascript_source_id,
        javascript_library_id: javascript_library_id
      ) do
    {:ok, %{"data" => javascript_library_data}} =
      Client.post(client, "/javascript_library_usages", %{
        "javascript_library" => %{
          "javascript_source_id" => javascript_source_id,
          "javascript_library_id" => javascript_library_id
        }
      })

    {:ok,
     %__MODULE__{
       id: javascript_library_data["id"],
       javascript_source_id: javascript_library_data["javascript_source_id"],
       javascript_library_id: javascript_library_data["javascript_library_id"],
       inserted_at: javascript_library_data["inserted_at"]
     }}
  end
end
