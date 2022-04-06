defmodule InvitationTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "can accpet invitation" do
    stub_json = """
    {"data":{"secret_key":"c9572706-36e5-48c2-86be-7429ae4c3bae",
              "account_id":"aee969dd-f91a-4cb4-ac35-b69e1716f25b",
              "account_name":"test name",
              "inviter_id":"f8c7e5b6-1064-4c22-ae9e-17f94af4bd33",
              "inviter_name":"a name",
              "invited":"947cf378-610c-4282-9c9a-c6974a1cf28a",
              "accepted_at":"when"
    }
    }
    """
    accepted = %{
      accepted: true,
    }

    request_body = Jason.encode!(accepted)

    api = OttoApi.Client.new("jwt", "http://example.com/api/v2")

    OttoApi.Http.MockClient
    |> expect(:put, fn _url, request_body, _headers, _options -> {:ok, %{status_code: 200, body: stub_json}} end)

    assert OttoApi.Invitation.accept(api, "c9572706-36e5-48c2-86be-7429ae4c3bae") ==
             {:ok,
                %OttoApi.Invitation{
                secret_key: "c9572706-36e5-48c2-86be-7429ae4c3bae",
                account_id: "aee969dd-f91a-4cb4-ac35-b69e1716f25b",
                account_name: "test name",
                inviter_id: "f8c7e5b6-1064-4c22-ae9e-17f94af4bd33",
                inviter_name: "a name",
                invited: "947cf378-610c-4282-9c9a-c6974a1cf28a",
                accepted_at: "when"
                }
              }
  end
end
