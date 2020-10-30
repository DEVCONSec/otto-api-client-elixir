defmodule OttoApiClientTest do
  use ExUnit.Case
  import Mox

  doctest OttoApiClient
  setup :verify_on_exit!


  test "does a GET" do
    stub_json = """
    ["a", "b", "c"]
    """
    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")
    OttoApi.Http.MockClient 
    |> expect(:get, fn(_url, _headers, _options) -> {:ok, stub_json} end)
    assert OttoApi.Client.get(api, "/a/path") == {:ok, %{body: ["a", "b", "c"]} }
  end
end
