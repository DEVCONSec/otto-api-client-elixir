defmodule StatusTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can get api status" do
    stub_json = """
    {
      "data": {
        "build_info": {
          "app_version": "0.0.0-dev",
          "build_date_time": "2020-08-31T17:39:22Z",
          "build_hash": "0",
          "build_number": "0",
          "build_tag": "0",
          "org_name": "devcon",
          "repo_name": "devcon-services-api"
        },
        "uptime_seconds": 3,
        "utc_now": "2020-08-31T17:39:25Z",
        "utc_service_start": "2020-08-31T17:39:25Z",
        "version": "0.14.0-1-gc92b1d3-dirty"
      }
    }
    """

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:get, fn _url, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Status.get(api) ==
             {:ok,
              %OttoApi.Status{
                build_info: %OttoApi.Status.BuildInfo{
                  app_version: "0.0.0-dev",
                  build_date_time: "2020-08-31T17:39:22Z",
                  build_hash: "0",
                  build_number: "0",
                  build_tag: "0",
                  org_name: "devcon",
                  repo_name: "devcon-services-api"
                },
                uptime_seconds: 3,
                utc_now: "2020-08-31T17:39:25Z",
                utc_service_start: "2020-08-31T17:39:25Z",
                version: "0.14.0-1-gc92b1d3-dirty"
              }}
  end
end
