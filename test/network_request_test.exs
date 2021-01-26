defmodule NetworkMonitorTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "get network_requests" do
    stub_json = """
    {"data":[{
      "id":"123456",
      "hostname": "devcon.technology",
      "path": "/path",
      "url": "https://devcon.technology/path",
      "url_found_on": "https://example.com/path",
      "initiator": "",
      "request_type": "xmlhttprequest",
      "site_id": "12345",
      "severity" : 1,
      "ignored": false,
      "resolved": false,
      "blocked": false,
      "is_blocked": false,
      "first_seen": "when",
      "last_seen": "when"
      }
    ]}
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.NetworkRequest.all(api, "12345", "12345") ==
             {:ok,
              [
                %OttoApi.NetworkRequest{
                  id: "123456",
                  hostname: "devcon.technology",
                  path: "/path",
                  url: "https://devcon.technology/path",
                  initiator: "",
                  request_type: "xmlhttprequest",
                  severity: 1,
                  site_id: "12345",
                  ignored: false,
                  resolved: false,
                  url_found_on: "https://example.com/path",
                  blocked: false,
                  is_blocked: false,
                  first_seen: "when",
                  last_seen: "when"
                }
              ]}
  end

  test "get network exposure aggregations" do
    stub_json = """
    {"data":{
      "count" : 100,
      "unique_clients" : 12,
      "unique_mobile" : 6,
      "unique_desktop": 6
      }
    }
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.NetworkExposureAggregation.get(api, "123456", "123456", "123456") ==
             {:ok,
              %OttoApi.NetworkExposureAggregation{
                count: 100,
                unique_clients: 12,
                unique_mobile: 6,
                unique_desktop: 6
              }}
  end
end
