defmodule OttoApi.Http.Client do
    @behaviour OttoApi.Http.Behaviour
    defdelegate get(url, headers, options), to: HTTPoison     
    defdelegate delete(url, headers, options), to: HTTPoison
    defdelegate post(url, body, headers, options), to: HTTPoison
    defdelegate patch(url, body, headers, options), to: HTTPoison
    defdelegate put(url, body, headers, options), to: HTTPoison
end