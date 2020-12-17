defmodule OttoApi.Me do
  defstruct [:account_id, :auth0_user_id, :id, :account_name, :account_description]

  alias OttoApi.Client

  def get(client) do
    case Client.get(client, "/me") do
      {:ok,
       %{
         "data" => %{
           "id" => id,
           "auth0_user_id" => auth0_user_id,
           "account_id" => account_id,
           "account_name" => account_name,
           "account_description" => account_description
         }
       }} ->
        {:ok,
         %__MODULE__{
           auth0_user_id: auth0_user_id,
           account_id: account_id,
           account_name: account_name,
           account_description: account_description,
           id: id
         }}

      {:error, result} ->
        {:error, result}
    end
  end
end
