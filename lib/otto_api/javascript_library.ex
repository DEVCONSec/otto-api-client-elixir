#
defmodule OttoApi.JavascriptLibrary do
  @moduledoc """
  Represents a named JavaScript library, such as vue.js or jQuery.
  A JavaScript library has a name and a version.  It can optionally be
  marked public (only by the system) to signify an open source or otherwise
  publicly accessible library.  Public library records are populated and maintained by Otto.

  Users can create their own JavaScript library records to name and version their own code.
  Users cannot mark their libraries as public.
  """
  @enforce_keys [:name, :version]
  defstruct @enforce_keys ++ [:id, :public, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             name: binary,
             version: binary,
             public: boolean,
             inserted_at: binary
           })}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/javascript_libraries")

    javascript_libraries =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "name" => name,
          "version" => version,
          "public" => public,
          "inserted_at" => inserted_at
        } = record

        %__MODULE__{
          id: id,
          name: name,
          version: version,
          public: public,
          inserted_at: inserted_at
        }
      end)

    {:ok, javascript_libraries}
  end

  def create(client, javascript_library_attributes) do
    {:ok, %{"data" => javascript_library_data}} =
      Client.post(client, "/javascript_libraries", %{
        "javascript_library" => javascript_library_attributes
      })

    {:ok,
     %__MODULE__{
       id: javascript_library_data["id"],
       name: javascript_library_data["name"],
       version: javascript_library_data["version"],
       public: javascript_library_data["public"],
       inserted_at: javascript_library_data["inserted_at"]
     }}
  end
end
