defmodule AccountTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get associated accounts" do
    stub_json = """
    {"data":[{"id":"c9572706-36e5-48c2-86be-7429ae4c3bae", "name":"a name", "description":"a description", "inserted_at":"when"}]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

    assert OttoApi.Account.all(api) ==
             {:ok,
              [
                %OttoApi.Account{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  name: "a name",
                  description: "a description",
                  inserted_at: "when"
                }
              ]}
  end

  test "can create account on service from struct" do
    account = %{
      name: "a name",
      description: "a description",
    }

    request_body = Jason.encode!(account)
    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:post, fn _url, request_body, _headers, _options -> {:ok, %{body: ""}} end)

    assert OttoApi.Account.create(api, account) == {:ok, %{}}
  end
end
