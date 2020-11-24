#
defmodule OttoApi.JavascriptSource do
  @moduledoc """
  Represents JavaScript source files discovered on the Web.
  The belong to a URL on which they are (or were) present.

  A JavaScript source is associated with 0 or more JavaScript libraries,
  which it contains.
  """
  @enforce_keys [:src, :url_id]
  defstruct @enforce_keys ++ [:id, :javascript_libraries, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             src: binary,
             url_id: binary,
             javascript_libraries: list(%OttoApi.JavascriptLibrary{}),
             inserted_at: binary
           })}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/javascript_sources")

    javascript_sources =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "src" => src,
          "url_id" => url_id,
          "javascript_libraries" => javascript_libraries,
          "inserted_at" => inserted_at
        } = record

        javascript_library_structs =
          Enum.map(javascript_libraries, fn lib ->
            %OttoApi.JavascriptLibrary{
              id: lib["id"],
              public: lib["public"],
              name: lib["name"],
              version: lib["version"],
              inserted_at: lib["inserted_at"]
            }
          end)

        %__MODULE__{
          id: id,
          src: src,
          url_id: url_id,
          javascript_libraries: javascript_library_structs,
          inserted_at: inserted_at
        }
      end)

    {:ok, javascript_sources}
  end
end
