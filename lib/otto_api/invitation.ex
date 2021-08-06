defmodule OttoApi.Invitation do
  @enforce_keys [:account_id, :secret_key]
  defstruct @enforce_keys ++ [:account_name, :inviter, :inviter_name,  :inviter_id, :invited, :invited_id, :accepted_at]

  alias OttoApi.Client

  def accept(client, secret_key) do
    case Client.put(client, "/invitation/accept", %{"id" => secret_key, "invitation" => %{"accepted" =>  true}}) do
      {:ok, %{"data" => invitation_attributes}} ->
        {:ok,
         %__MODULE__{
           secret_key: invitation_attributes["secret_key"],
           account_id: invitation_attributes["account_id"],
           account_name: invitation_attributes["account_name"],
           inviter_id: invitation_attributes["inviter_id"],
           inviter_name: invitation_attributes["inviter_name"],
           invited: invitation_attributes["invited"],
           accepted_at: invitation_attributes["accepted_at"]
         }}

      anything_else ->
        anything_else
    end
  end
end

