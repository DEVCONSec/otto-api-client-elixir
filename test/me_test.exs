defmodule MeTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get me" do
    stub_json = """
    {
      "data": {
        "auth0_user_id": "12345",
        "id":"12345",
        "account_name":"hello",
        "account_description":"wow",
        "account_id":"12345"
      }
    }
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Me.get(api) ==
             {:ok,
              %OttoApi.Me{
                account_id: "12345",
                auth0_user_id: "12345",
                id: "12345",
                account_name: "hello",
                account_description: "wow"
              }}
  end

  test "canNOT get me" do
    stub_json = """
    {
      "errors": {
        "detail": "Not found"
      }
    }
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 404, body: stub_json}} end)

    assert OttoApi.Me.get(api) ==
             {:error, "Resource missing" }
  end
end
