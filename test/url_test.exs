defmodule UrlTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get associated urls" do
    stub_json = """
    {"data":[{"id":"c9572706-36e5-48c2-86be-7429ae4c3bae", "url":"https://www.example.com", "site_id":"123456", "inserted_at":"when"}]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

    assert OttoApi.Url.all(api, "123456", "12345") ==
             {:ok,
              [
                %OttoApi.Url{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  url: "https://www.example.com",
                  site_id: "123456",
                  inserted_at: "when"
                }
              ]}
  end

  test "can create url on service from struct" do
    url = %{
      url: "https://www.example.com",
      site_id: "123456"
    }

    request_body = Jason.encode!(url)
    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    response_body = """
    {"data":{"id":"123456",
              "url":"https://www.example.com",
              "site_id":"123456",
              "inserted_at": "when"
              }
            }
    """

    OttoApi.Http.MockClient
    |> expect(:post, fn _url, request_body, _headers, _options ->
      {:ok, %{body: response_body}}
    end)

    assert OttoApi.Url.create(api, "123456", url) ==
             {:ok,
              %OttoApi.Url{
                id: "123456",
                url: "https://www.example.com",
                site_id: "123456",
                inserted_at: "when"
              }}
  end
end
