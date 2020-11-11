defmodule Site do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get all sites for account" do
    stub_json = """
    {"data":[{"id":"c9572706-36e5-48c2-86be-7429ae4c3bae", "url":"https://example.com", "account_id":"an account id", "inserted_at":"when"}]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

    assert OttoApi.Site.all(api) ==
             {:ok,
              [
                %OttoApi.Site{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  url: "https://example.com",
                  account_id: "an account id",
                  inserted_at: "when"
                }
              ]}
  end

  test "can create site from struct" do
    site  = %OttoApi.Site{
      id: "lkjsdflksfdj",
      url: "https://example.com",
      account_id: "account's id",
      inserted_at: "when"
    }

    request_body = Jason.encode!(Map.from_struct(site))
    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:post, fn _url, request_body, _headers, _options -> {:ok, %{body: ""}} end)

    assert OttoApi.Site.create(api, site) == {:ok, %{}}
  end
end
