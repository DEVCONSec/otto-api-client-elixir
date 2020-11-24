defmodule JavascriptSourceTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get associated jobs" do
    stub_json = """
    {"data":[{"id":"c9572706-36e5-48c2-86be-7429ae4c3bae",
    "url_id":"123456",
    "src": "https://example.com/x.js",
    "javascript_libraries" : [{"id": "654321", "name": "jQuery", "version":"0.0.1", "public": true, "inserted_at":"when"}],
    "inserted_at":"when"}]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

    assert OttoApi.JavascriptSource.all(api) ==
             {:ok,
              [
                %OttoApi.JavascriptSource{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  url_id: "123456",
                  src: "https://example.com/x.js",
                  javascript_libraries: [
                    %OttoApi.JavascriptLibrary{
                      id: "654321",
                      name: "jQuery",
                      version: "0.0.1",
                      public: true,
                      inserted_at: "when"
                    }
                  ],
                  inserted_at: "when"
                }
              ]}
  end
end
