defmodule OttoApi.Me do
  defstruct [:account_id, :auth0_user_id, :id]

  alias OttoApi.Client

  def get(client) do
    case Client.get(client, "/me") do
      {:ok,
       %{
         "data" => %{
           "id" => id,
           "auth0_user_id" => auth0_user_id,
           "account_id" => account_id
         }
       }} ->
        {:ok,
         %__MODULE__{
           auth0_user_id: auth0_user_id,
           account_id: account_id,
           id: id
         }}

      {:error, result} ->
        {:error, result}
    end
  end
end
