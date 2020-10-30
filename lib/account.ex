defmodule OttoApi.Account do
    alias OttoApi.Client
    def all(client) do
      Client.get(client, "/accounts")
    end
end