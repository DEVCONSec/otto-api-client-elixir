defmodule AlertTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get alerts" do
    stub_json = """
    {"data":[
      {"id":"c9572706-36e5-48c2-86be-7429ae4c3bae", "site_id":"123456", "alert_type_id" : 1, "description" : "this is alert data", "inserted_at":"when"},
      {"id":"c95727XX-36e5-48c2-86be-7429ae4c3bXX", "site_id":"123456", "alert_type_id" : 2, "description" : "this is alert data for another alert", "inserted_at":"when"}
      ]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

   data = OttoApi.Alert.all(api, "123456", "12345")
   IO.puts "JOSH"
   IO.inspect data
    assert data ==
             {:ok,
              [
                %OttoApi.Alert{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  site_id: "123456",
                  alert_type_id: 1,
                  description: "this is alert data",
                  inserted_at: "when"
                },
                %OttoApi.Alert{
                  id: "c95727XX-36e5-48c2-86be-7429ae4c3bXX",
                  site_id: "123456",
                  alert_type_id: 2,
                  description: "this is alert data for another alert",
                  inserted_at: "when"
                }
              ]}
  end

end
