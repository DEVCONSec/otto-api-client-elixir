defmodule OttoApi.Client do
    @enforce_keys [:jwt, :client_id, :url]
    defstruct @enforce_keys

    def new(jwt, client_id, url) do
      %__MODULE__{jwt: jwt, client_id: client_id, url: url}
    end

    def get(client, path) do
        request_without_body(:get, client, path)
    end

    def patch(client, path, body) do
        request_with_body(:patch, client, path, body)
    end

    def post(client, path, body) do
        request_with_body(:post, client, path, body)
    end

    def delete(client, path) do
        request_without_body(:delete, client, path)
    end

    def put(client, path, body) do
        request_with_body(:put, client, path, body)
    end

    defp request_with_body(verb, client, path, body) do
        IO.puts(full_url(client.url, path))
        with {:ok, json} <- Jason.encode(body) do
            {:ok, response} = HTTPoison.post(full_url(client.url, path), json, headers(client))
            Jason.decode(response.body)
        end
    end

    defp request_without_body(verb, client, path) do
        {:ok, response} = apply(HTTPoison, verb, [full_url(client.url, path), headers(client)])
        Jason.decode(response.body)
    end

    defp headers(client) do
        [
            {"Authorization",  "Bearer #{client.jwt}"},
            {"Content-Type", "application/json"},
            {"Accept", "application/json"}
        ]
    end

    defp full_url(url, path) do
        Enum.join([url, path])
    end
end

# eyJhbGciOiJIUzI1NiIsImRldmNvbl9qd3RfdHlwZSI6ImNsaWVudF9hdXRoZW50aWNhdGlvbl90b2tlbiIsImtpZCI6Ijc4NGM3MzM2LWRhZGUtNDc1ZC05YjFkLTc3OGYzNDhlMDkyMyIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJkZXZjb25fc2VydmljZXNfYXBpIiwiZGV2Y29uX2NsYWltcyI6eyJhY2NvdW50X2lkIjoiYzk1NzI3MDYtMzZlNS00OGMyLTg2YmUtNzQyOWFlNGMzYmFlIiwiY2xpZW50X2F1dGhlbnRpY2F0aW9uX2tleV9pZCI6Ijc4NGM3MzM2LWRhZGUtNDc1ZC05YjFkLTc3OGYzNDhlMDkyMyIsImNsaWVudF9pZCI6IjllOWYwYTMyLTA1MzQtNDRiYy05ZjJhLTcwYmUwNThkNDE0NyJ9LCJpYXQiOjE2MDIyNTY0NjAsImlzcyI6ImRldmNvbl9zZXJ2aWNlc19hcGkiLCJzdWIiOiJjbGllbnRzLzllOWYwYTMyLTA1MzQtNDRiYy05ZjJhLTcwYmUwNThkNDE0NyJ9.PZLnJO0Zt90vR-_mNb-J12tNvPZ5iUVxKU_Bl6nfdWE
#https://dev-api.devconops.com/api/v2/clients/9e9f0a32-0534-44bc-9f2a-70be058d4147


x="""
j = %{
    "page_issue" => %{
      "content" => "User tracking information sent to google-analytics.com",
      "count" => 1,
      "created_at" => "2020-10-30T15:54:23.180Z",
      "data" => %{"hostname" => "hkehldibimafabbimfchcagnjokpjblf"},
      "displayLabel" => "Google Analytics User Tracking Detected",
      "issue_type" => "Google Analytics User Tracking Detected",
      "severity" => 10,
      "url" => "chrome-extension://hkehldibimafabbimfchcagnjokpjblf"
    }
  }

api = OttoApi.Client.new("eyJhbGciOiJIUzI1NiIsImRldmNvbl9qd3RfdHlwZSI6ImNsaWVudF9hdXRoZW50aWNhdGlvbl90b2tlbiIsImtpZCI6Ijc4NGM3MzM2LWRhZGUtNDc1ZC05YjFkLTc3OGYzNDhlMDkyMyIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJkZXZjb25fc2VydmljZXNfYXBpIiwiZGV2Y29uX2NsYWltcyI6eyJhY2NvdW50X2lkIjoiYzk1NzI3MDYtMzZlNS00OGMyLTg2YmUtNzQyOWFlNGMzYmFlIiwiY2xpZW50X2F1dGhlbnRpY2F0aW9uX2tleV9pZCI6Ijc4NGM3MzM2LWRhZGUtNDc1ZC05YjFkLTc3OGYzNDhlMDkyMyIsImNsaWVudF9pZCI6IjllOWYwYTMyLTA1MzQtNDRiYy05ZjJhLTcwYmUwNThkNDE0NyJ9LCJpYXQiOjE2MDIyNTY0NjAsImlzcyI6ImRldmNvbl9zZXJ2aWNlc19hcGkiLCJzdWIiOiJjbGllbnRzLzllOWYwYTMyLTA1MzQtNDRiYy05ZjJhLTcwYmUwNThkNDE0NyJ9.PZLnJO0Zt90vR-_mNb-J12tNvPZ5iUVxKU_Bl6nfdWE", 
                         "9e9f0a32-0534-44bc-9f2a-70be058d4147", 
                         "https://dev-api.devconops.com/api/v2")

api |> OttoApi.Client.post("/clients/9e9f0a32-0534-44bc-9f2a-70be058d4147/analytics/page-issues", j)
api |> OttoApi.Account.all

api = OttoApi.Client.new("longjwthere", "https://dev-api.devconops.com/api/v2")

api |> OttoApi.Client.Organization.find("9e9f0a32-0534-44bc-9f2a-70be058d4147")
"""