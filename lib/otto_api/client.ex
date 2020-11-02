defmodule OttoApi.Client do
  @http_client Application.get_env(:otto_api, :http_client, OttoApi.Http.Client)

  @enforce_keys [:jwt, :client_id, :base_url]
  defstruct @enforce_keys

  @spec new(jwt :: binary, client_id :: binary, base_url :: binary) :: %__MODULE__{
          jwt: binary,
          client_id: binary,
          base_url: binary
        }
  def new(jwt, client_id, base_url) do
    %__MODULE__{jwt: jwt, client_id: client_id, base_url: base_url}
  end

  @spec get(client :: binary, path :: binary) :: {:ok, %{}} | {:error, message :: binary}
  def get(client, path) do
    request_without_body(:get, client, path)
  end

  @spec patch(client :: binary, path :: binary, body :: binary) :: {:ok, %{}} | {:error, message :: binary}
  def patch(client, path, body) do
    request_with_body(:patch, client, path, body)
  end

  @spec post(client :: binary, path :: binary, body :: binary) :: {:ok, %{}} | {:error, message :: binary}
  def post(client, path, body) do
    request_with_body(:post, client, path, body)
  end

  @spec delete(client :: binary, path :: binary) :: {:ok, %{}} | {:error, message :: binary}
  def delete(client, path) do
    request_without_body(:delete, client, path)
  end

  @spec put(client :: binary, path :: binary, body :: binary) :: {:ok, %{}} | {:error, message :: binary}
  def put(client, path, body) do
    request_with_body(:put, client, path, body)
  end

  defp request_with_body(verb, client, path, body) do
    with {:ok, json} <- Jason.encode(body) do
      {:ok, response} =
        apply(@http_client, verb, [full_url(client.base_url, path), json, headers(client)])

      Jason.decode(response.body)
    end
  end

  defp request_without_body(verb, client, path) do
    {:ok, response} =
      apply(@http_client, verb, [full_url(client.base_url, path), headers(client), []])

    Jason.decode(response.body)
  end

  defp headers(client) do
    [
      {"Authorization", "Bearer #{client.jwt}"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]
  end

  defp full_url(url, path) do
    Enum.join([url, path])
  end
end
