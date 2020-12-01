defmodule AlertTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get alerts" do
    stub_json = """
    {"data":[
      {"id": "c9572706-36e5-48c2-86be-7429ae4c3bae",
      "site_id": "123456",
      "summary": "this is alert data",
      "alert_type": { "id": "c9572706-36e5-48c2-86be-7429ae4c3bae", "name": "Data Skimming", "description": "Data Skimming Desc", "severity": "high"},
      "detail": { "description": "Data Skimming Desc", "origin": "origin stuff", "destination": "destination stuff" },
      "alert_count": [[12,"test123"], [13,"321tset"]],
      "inserted_at": "when"
     }
      ]}
    """

    api = OttoApi.Client.new("jwt", "client id", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{body: stub_json}} end)

   data = OttoApi.Alert.all(api, "123456", "12345")
    assert data ==
             {:ok,
              [
                %OttoApi.Alert{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  site_id: "123456",
                  summary: "this is alert data",
                  alert_type: %{ id: "c9572706-36e5-48c2-86be-7429ae4c3bae", name: "Data Skimming", description: "Data Skimming Desc", severity: "high"},
                  detail: %{ description: "Data Skimming Desc", origin: "origin stuff", destination: "destination stuff" },
                  alert_count: [[12,"test123"], [13,"321tset"]],
                  inserted_at: "when"
                }
              ]}
  end

end
