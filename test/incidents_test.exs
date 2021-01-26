defmodule IncidentsTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "get incidents" do
    stub_json = """
    {"data":[{
      "id":"123456",
      "account_id": "123456",
      "site_id": "123456",
      "threat_id": "123456",
      "dom_location": "IMG",
      "event_name": "Click Event",
      "ignored": false,
      "resolved": false,
      "blocked": false,
      "is_blocked": true,
      "stack_trace": "test stack",
      "url_found_on": "https://www.devcon.technology",
      "source_code": "test code",
      "first_seen": "when",
      "last_seen": "when"
      }
    ]}
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Incident.all(api, "12345", "12345") ==
             {:ok,
              [
                %OttoApi.Incident{
                  id: "123456",
                  account_id: "123456",
                  site_id: "123456",
                  threat_id: "123456",
                  dom_location: "IMG",
                  event_name: "Click Event",
                  ignored: false,
                  resolved: false,
                  blocked: false,
                  is_blocked: true,
                  stack_trace: "test stack",
                  url_found_on: "https://www.devcon.technology",
                  source_code: "test code",
                  first_seen: "when",
                  last_seen: "when"
                }
              ]}
  end

  test "get threats" do
    stub_json = """
    {"data":[{
      "id":"123456",
      "name": "Threat Name",
      "description": "Threat Description",
      "severity": 1
      }
    ]}
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Threat.all(api) ==
             {:ok,
              [
                %OttoApi.Threat{
                  id: "123456",
                  name: "Threat Name",
                  description: "Threat Description",
                  severity: 1
                }
              ]}
  end

  test "get exposure aggregations" do
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

    assert OttoApi.ExposureAggregation.get(api, "123456", "123456", "123456") ==
             {:ok,
              %OttoApi.ExposureAggregation{
                count: 100,
                unique_clients: 12,
                unique_mobile: 6,
                unique_desktop: 6
              }}
  end

  test "get a singe incident" do
    stub_json = """
    {"data":{
      "id":"123456",
      "account_id": "123456",
      "site_id": "123456",
      "threat_id": "123456",
      "dom_location": "IMG",
      "event_name": "Click Event",
      "ignored": false,
      "resolved": false,
      "blocked": false,
      "is_blocked": true,
      "stack_trace": "test stack",
      "url_found_on": "https://www.devcon.technology",
      "source_code": "test code",
      "first_seen": "when",
      "last_seen": "when"
      }
    }
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Incident.get(api, "12345", "12345", "12345") ==
             {:ok,
              %OttoApi.Incident{
                id: "123456",
                account_id: "123456",
                site_id: "123456",
                threat_id: "123456",
                dom_location: "IMG",
                event_name: "Click Event",
                ignored: false,
                resolved: false,
                blocked: false,
                is_blocked: true,
                stack_trace: "test stack",
                url_found_on: "https://www.devcon.technology",
                source_code: "test code",
                first_seen: "when",
                last_seen: "when"
              }}
  end
end
