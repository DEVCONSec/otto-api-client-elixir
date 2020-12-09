defmodule OttoApi.Me do
  defstruct [:account_id, :auth0_user_id, :id]


  alias OttoApi.Client

  def get(client) do
    {:ok,
     %{
       "data" => %{
         "id" => id,
         "auth0_user_id" => auth0_user_id,
         "account_id" => account_id
       }
     }} = Client.get(client, "/me")

    {:ok,
     %__MODULE__{
       auth0_user_id: auth0_user_id,
       account_id: account_id,
       id: id
     }
    }
  end
end
