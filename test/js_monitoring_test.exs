defmodule JsMonitoringJobTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get associated jobs" do
    stub_json = """
    {"data":[{"id":"c9572706-36e5-48c2-86be-7429ae4c3bae",
    "site_id":"123456",
    "synthetic_check_frequency": "1",
    "synthetic_check_location_usa" : true,
    "synthetic_check_location_global" : false,
    "data_retention_period_in_days" : 1,
    "inserted_at":"when"}]}
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.JsMonitoringJob.all(api) ==
             {:ok,
              [
                %OttoApi.JsMonitoringJob{
                  id: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                  site_id: "123456",
                  synthetic_check_frequency: "1",
                  synthetic_check_location_usa: true,
                  synthetic_check_location_global: false,
                  data_retention_period_in_days: 1,
                  inserted_at: "when"
                }
              ]}
  end

  test "can create job on siteid from struct" do
    job = %{
      site_id: "123456",
      synthetic_check_frequency: "1",
      synthetic_check_location_usa: true,
      synthetic_check_location_global: false,
      data_retention_period_in_days: 1
    }

    request_body = Jason.encode!(job)
    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    response_body = """
    {"data":{"id":"123456",
              "site_id":"123456",
              "synthetic_check_frequency": "1",
              "synthetic_check_location_usa": true,
              "synthetic_check_location_global": false,
              "data_retention_period_in_days": 1,
              "inserted_at": "when"
              }
            }
    """

    OttoApi.Http.MockClient
    |> expect(:post, fn _url, request_body, _headers, _options ->
      {:ok, %{status_code: 200, body: response_body}}
    end)

    assert OttoApi.JsMonitoringJob.create(api, job) ==
             {:ok,
              %OttoApi.JsMonitoringJob{
                id: "123456",
                site_id: "123456",
                synthetic_check_frequency: "1",
                synthetic_check_location_usa: true,
                synthetic_check_location_global: false,
                data_retention_period_in_days: 1,
                inserted_at: "when"
              }}
  end
end
